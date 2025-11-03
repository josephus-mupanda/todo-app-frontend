import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_frontend/data/models/task.dart';
import 'package:todo_frontend/data/providers/task_provider.dart';
import '../../../core/constants/constants.dart';
import '../../../core/utils/toast.dart';
import '../../../core/widgets/button_widget.dart';
import '../../../core/widgets/input_widget.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _taskController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  String _searchQuery = '';
  TaskFilter _currentFilter = TaskFilter.all;
  bool _isLoading = false;
  bool _showAddTaskForm = false;

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    setState(() => _isLoading = true);
    try {
      final taskProvider = Provider.of<TaskProvider>(context, listen: false);
      await taskProvider.fetchTasks(context);
    } catch (e) {
      // Error is handled in the service
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints(maxWidth: Constants.kMaxWidth),
        child: Column(
          children: [
            // Search and Filter Section
            _buildSearchFilterSection(theme),
            
            // Add Task Form (Conditional)
            if (_showAddTaskForm) _buildAddTaskForm(theme),
            
            // Tasks List
            Expanded(
              child: _buildTasksList(theme),
            ),
          ],
        ),
      ),
      floatingActionButton: _showAddTaskForm ? null : FloatingActionButton(
        onPressed: () {
          setState(() {
            _showAddTaskForm = true;
          });
        },
        backgroundColor: theme.primaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildSearchFilterSection(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(Constants.kDefaultPadding),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Search Bar
          Row(
            children: [
              Expanded(
                child: InputWidget(
                  kController: _searchController,
                  obscureText: false,
                  hintText: 'Search tasks...',
                  prefixIcon: Icons.search,
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                ),
              ),
              const SizedBox(width: 12),
              Container(
                decoration: BoxDecoration(
                  color: theme.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  onPressed: _loadTasks,
                  icon: Icon(Icons.refresh, color: theme.primaryColor),
                  tooltip: 'Refresh',
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Filter Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: TaskFilter.values.map((filter) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(
                      _getFilterText(filter),
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: _currentFilter == filter ? Colors.white : null,
                      ),
                    ),
                    selected: _currentFilter == filter,
                    onSelected: (selected) {
                      setState(() {
                        _currentFilter = selected ? filter : TaskFilter.all;
                      });
                    },
                    backgroundColor: theme.cardColor,
                    selectedColor: theme.primaryColor,
                    checkmarkColor: Colors.white,
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddTaskForm(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(Constants.kDefaultPadding),
      margin: const EdgeInsets.all(Constants.kDefaultPadding),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.primaryColor.withOpacity(0.2)),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Add New Task',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _showAddTaskForm = false;
                      _taskController.clear();
                    });
                  },
                  icon: Icon(Icons.close, color: theme.colorScheme.onSurface.withOpacity(0.5)),
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            InputWidget(
              kController: _taskController,
              obscureText: false,
              hintText: 'Enter task title...',
              prefixIcon: Icons.task,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Task title is required';
                }
                return null;
              },
            ),
            
            const SizedBox(height: 16),
            
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    onPressed: _addTask,
                    text: 'Create Task',
                  ),
                ),
                const SizedBox(width: 12),
                AppButton(
                  onPressed: () {
                    setState(() {
                      _showAddTaskForm = false;
                      _taskController.clear();
                    });
                  },
                  text: 'Cancel',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTasksList(ThemeData theme) {
    return Consumer<TaskProvider>(
      builder: (context, taskProvider, child) {
        final filteredTasks = _getFilteredTasks(taskProvider.tasks);
        
        if (_isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        
        if (filteredTasks.isEmpty) {
          return _buildEmptyState(theme);
        }
        
        return RefreshIndicator(
          onRefresh: _loadTasks,
          child: ListView.separated(
            padding: const EdgeInsets.all(Constants.kDefaultPadding),
            itemCount: filteredTasks.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final task = filteredTasks[index];
              return _buildTaskCard(theme, task);
            },
          ),
        );
      },
    );
  }

  Widget _buildTaskCard(ThemeData theme, Task task) {
    return Dismissible(
      key: Key(task.id),
      direction: DismissDirection.endToStart,
      background: Container(
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.delete, color: Colors.red),
      ),
      confirmDismiss: (direction) async {
        return await _showDeleteConfirmation(task);
      },
      child: Card(
        color: theme.cardColor,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(16),
          leading: _buildCompletionIndicator(theme, task),
          title: Text(
            task.title,
            style: theme.textTheme.bodyLarge?.copyWith(
              decoration: task.completed ? TextDecoration.lineThrough : TextDecoration.none,
              color: task.completed ? theme.colorScheme.onSurface.withOpacity(0.5) : null,
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () => _toggleTaskCompletion(task),
                icon: Icon(
                  task.completed ? Icons.undo : Icons.check_circle,
                  color: task.completed ? Colors.orange : Colors.green,
                ),
                tooltip: task.completed ? 'Mark as Incomplete' : 'Mark as Complete',
              ),
              IconButton(
                onPressed: () => _deleteTask(task),
                icon: const Icon(Icons.delete, color: Colors.red),
                tooltip: 'Delete Task',
              ),
            ],
          ),
          onTap: () {
            // Navigate to task details if needed
            // Navigator.pushNamed(context, AppRoutes.taskDetails, arguments: task.id);
          },
        ),
      ),
    );
  }

  Widget _buildCompletionIndicator(ThemeData theme, Task task) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: task.completed 
            ? Colors.green.withOpacity(0.1)
            : Colors.orange.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(
        task.completed ? Icons.check_circle : Icons.access_time,
        color: task.completed ? Colors.green : Colors.orange,
        size: 20,
      ),
    );
  }

  Widget _buildEmptyState(ThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.task_alt,
            size: 80,
            color: theme.colorScheme.onSurface.withOpacity(0.3),
          ),
          const SizedBox(height: 20),
          Text(
            'No tasks found',
            style: theme.textTheme.titleLarge?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.5),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _searchQuery.isNotEmpty || _currentFilter != TaskFilter.all
                ? 'Try adjusting your search or filters'
                : 'Create your first task to get started!',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.5),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          AppButton(
            onPressed: () {
              setState(() {
                _showAddTaskForm = true;
              });
            },
            text: 'Create Task',
          ),
        ],
      ),
    );
  }

  List<Task> _getFilteredTasks(List<Task> tasks) {
    var filtered = tasks.where((task) {
      final matchesSearch = task.title.toLowerCase().contains(_searchQuery.toLowerCase());
      
      final matchesFilter = _currentFilter == TaskFilter.all ||
          (_currentFilter == TaskFilter.completed && task.completed) ||
          (_currentFilter == TaskFilter.pending && !task.completed);
      
      return matchesSearch && matchesFilter;
    }).toList();
    
    // Sort by completion status (pending first) then by title
    filtered.sort((a, b) {
      if (a.completed != b.completed) {
        return a.completed ? 1 : -1;
      }
      return a.title.compareTo(b.title);
    });
    
    return filtered;
  }

  String _getFilterText(TaskFilter filter) {
    switch (filter) {
      case TaskFilter.all:
        return 'All';
      case TaskFilter.pending:
        return 'Pending';
      case TaskFilter.completed:
        return 'Completed';
    }
  }

  Future<void> _addTask() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isLoading = true);
      
      try {
        final taskProvider = Provider.of<TaskProvider>(context, listen: false);
        await taskProvider.addTask(context, _taskController.text.trim());
        
        if (context.mounted) {
          setState(() {
            _showAddTaskForm = false;
            _taskController.clear();
          });
        }
      } catch (e) {
        // Error is handled in the service
      } finally {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      }
    }
  }

  Future<void> _toggleTaskCompletion(Task task) async {
    try {
      // Since your current API doesn't have update task status endpoint,
      // we'll need to delete and recreate with opposite status
      // Or you can add an update endpoint to your backend
      showInfoToast(context, "Update task feature coming soon!");
      
      // TODO: Implement when update endpoint is available
      // final taskProvider = Provider.of<TaskProvider>(context, listen: false);
      // await taskProvider.updateTaskStatus(context, task.id, !task.completed);
    } catch (e) {
      if (context.mounted) {
        showErrorToast(context, "Failed to update task");
      }
    }
  }

  Future<void> _deleteTask(Task task) async {
    try {
      final taskProvider = Provider.of<TaskProvider>(context, listen: false);
      await taskProvider.deleteTask(context, task.id);
    } catch (e) {
      // Error is handled in the service
    }
  }

  Future<bool> _showDeleteConfirmation(Task task) async {
    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete Task"),
          content: Text("Are you sure you want to delete '${task.title}'?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text("Delete"),
            ),
          ],
        );
      },
    ) ?? false;
  }

  @override
  void dispose() {
    _searchController.dispose();
    _taskController.dispose();
    super.dispose();
  }
}

// Add this enum for filtering
enum TaskFilter {
  all,
  pending,
  completed,
}