import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_frontend/core/widgets/delete_dialog.dart';
import 'package:todo_frontend/core/widgets/task_details_dialog.dart';
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
      // Error handled in service
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _addTask() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isLoading = true);
      try {
        final taskProvider = Provider.of<TaskProvider>(context, listen: false);
        await taskProvider.addTask(context, _taskController.text.trim());
        if (mounted) {
          setState(() {
            _showAddTaskForm = false;
            _taskController.clear();
          });
        }
      } catch (e) {
        // Error handled
      } finally {
        if (mounted) setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints(maxWidth: Constants.kMaxWidth),
        child: Column(
          children: [
            // Search + Filter
            _buildSearchFilterSection(theme),

            // Add Task Form
            if (_showAddTaskForm)
              Expanded(child: _buildAddTaskForm(theme)),

            // Task List
            Expanded(child: _buildTasksList(theme)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() => _showAddTaskForm = true);
        },
        child: const Icon(Icons.add),
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
            color: Colors.black.withValues(alpha:0.06),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: InputWidget(
                  kController: _searchController,
                  obscureText: false,
                  hintText: 'Search tasks...',
                  prefixIcon: Icons.search,
                  onChanged: (value) {
                    setState(() => _searchQuery = value);
                  },
                ),
              ),
              const SizedBox(width: 12),
              Container(
                decoration: BoxDecoration(
                  color: theme.primaryColor.withValues(alpha:0.6),
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
                        _currentFilter =
                            selected ? filter : TaskFilter.all;
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
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(Constants.kDefaultPadding),
        margin: const EdgeInsets.all(Constants.kDefaultPadding),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: theme.primaryColor.withValues(alpha:0.6)),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Add New Task',
                      style: theme.textTheme.titleLarge
                          ?.copyWith(fontWeight: FontWeight.w700),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _showAddTaskForm = false;
                        _taskController.clear();
                      });
                    },
                    icon: Icon(
                      Icons.close,
                      color: theme.colorScheme.onSurface.withValues(alpha:(0.6),
                    ),
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
                    child:
                        AppButton(onPressed: _addTask, text: 'Create Task'),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AppButton(
                      onPressed: () {
                        setState(() {
                          _showAddTaskForm = false;
                          _taskController.clear();
                        });
                      },
                      text: 'Cancel',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTasksList(ThemeData theme) {
    return Consumer<TaskProvider>(
      builder: (context, taskProvider, child) {
        final filteredTasks = _getFilteredTasks(taskProvider.tasks);

        if (_isLoading) return const Center(child: CircularProgressIndicator());
        if (filteredTasks.isEmpty) return _buildEmptyState(theme);

        return RefreshIndicator(
          onRefresh: _loadTasks,
          child: ListView.separated(
            padding: const EdgeInsets.all(Constants.kDefaultPadding),
            itemCount: filteredTasks.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (_, index) {
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
          color: Colors.red.withValues(alpha:0.6),
          borderRadius: BorderRadius.circular(16),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.delete, color: Colors.red),
      ),
      onDismissed: (_) => _showDeleteConfirmation(task),
      child: Card(
        color: theme.cardColor,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: ListTile(
          contentPadding: const EdgeInsets.all(16),
          leading: _buildCompletionIndicator(theme, task),
          title: Text(
            task.title,
            style: theme.textTheme.bodyLarge?.copyWith(
              decoration: task.completed
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
              color: task.completed
                  ? theme.colorScheme.onSurface.withValues(alpha:0.6)
                  : null,
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
                tooltip:
                    task.completed ? 'Mark as Incomplete' : 'Mark as Complete',
              ),
              IconButton(
                onPressed: () => _showDeleteConfirmation(task),
                icon: const Icon(Icons.delete, color: Colors.red),
                tooltip: 'Delete Task',
              ),
            ],
          ),
          onTap: () => _showTaskDetails(task),
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
            ? Colors.green.withValues(alpha:0.1)
            : Colors.orange.withValues(alpha:0.6),
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
            size: 60,
            color: theme.colorScheme.onSurface.withValues(alpha: .6),
          ),
          const SizedBox(height: 10),
          Text(
            'No tasks found',
            style: theme.textTheme.titleLarge?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: .6),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _searchQuery.isNotEmpty || _currentFilter != TaskFilter.all
                ? 'Try adjusting your search or filters'
                : 'Create your first task to get started!',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: .6),
            ),
            textAlign: TextAlign.center,
          ),
        
        ],
      ),
    );
  }

  List<Task> _getFilteredTasks(List<Task> tasks) {
    final filtered = tasks.where((task) {
      final matchesSearch =
          task.title.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesFilter = _currentFilter == TaskFilter.all ||
          (_currentFilter == TaskFilter.completed && task.completed) ||
          (_currentFilter == TaskFilter.pending && !task.completed);
      return matchesSearch && matchesFilter;
    }).toList();

    filtered.sort((a, b) {
      if (a.completed != b.completed) return a.completed ? 1 : -1;
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

  Future<void> _toggleTaskCompletion(Task task) async {
    showInfoToast(context, "Update task feature coming soon!");
  }

  void _showTaskDetails(Task task) {
    showDialog(
      context: context,
      builder: (_) => TaskDetailsDialog(
        task: task,
        onEdit: () => _editTask(task),
        onToggleComplete: () => _toggleTaskCompletion(task),
        onDelete: () => _showDeleteConfirmation(task),
      ),
    );
  }

  void _showDeleteConfirmation(Task task) {
    showDialog(
      context: context,
      builder: (_) => DeleteConfirmationDialog(
        title: 'Delete Task',
        content:
            'This action cannot be undone. Are you sure you want to delete this task?',
        itemName: task.title,
        onConfirm: () => _deleteTask(task),
      ),
    );
  }

  Future<void> _deleteTask(Task task) async {
    try {
      final taskProvider = Provider.of<TaskProvider>(context, listen: false);
      await taskProvider.deleteTask(context, task.id);
    } catch (_) {}
  }

  void _editTask(Task task) {
    showInfoToast(context, "Edit task feature coming soon!");
  }

  @override
  void dispose() {
    _searchController.dispose();
    _taskController.dispose();
    super.dispose();
  }
}

enum TaskFilter { all, pending, completed }
