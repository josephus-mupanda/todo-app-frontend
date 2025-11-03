import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import '../../../core/constants/constants.dart';
import '../../../data/models/task.dart';

class TaskDetailsDialog extends StatelessWidget {
  final Task task;
  final VoidCallback onEdit;
  final VoidCallback onToggleComplete;
  final VoidCallback onDelete;

  const TaskDetailsDialog({
    super.key,
    required this.task,
    required this.onEdit,
    required this.onToggleComplete,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return AlertDialog(
      backgroundColor: theme.cardColor,
      title: Center(
        child: Column(
          children: [
            const SizedBox(height: Constants.kDefaultPadding / 2),
            Icon(
              FeatherIcons.fileText,
              size: 40,
              color: theme.primaryColor,
            ),
            const SizedBox(height: Constants.kDefaultPadding / 2),
            Text(
              'Task Details',
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Task Title
            Text(
              'Title',
              style: theme.textTheme.labelMedium?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.6),
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              task.title,
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: Constants.kDefaultPadding),
            
            // Status
            Text(
              'Status',
              style: theme.textTheme.labelMedium?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.6),
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: task.completed 
                    ? Colors.green.withOpacity(0.1)
                    : Colors.orange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: task.completed ? Colors.green : Colors.orange,
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    task.completed ? FeatherIcons.checkCircle : FeatherIcons.clock,
                    size: 14,
                    color: task.completed ? Colors.green : Colors.orange,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    task.completed ? 'Completed' : 'Pending',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: task.completed ? Colors.green : Colors.orange,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: Constants.kDefaultPadding),
            
            // Task ID
            Text(
              'Task ID',
              style: theme.textTheme.labelMedium?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.6),
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              task.id,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.7),
                fontFamily: 'Monospace',
              ),
            ),
          ],
        ),
      ),
      actions: [
        Row(
          children: [
            // Edit Button
            Expanded(
              child: TextButton.icon(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  backgroundColor: theme.primaryColor.withOpacity(0.1),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  onEdit();
                },
                icon: Icon(FeatherIcons.edit, color: theme.primaryColor, size: 16),
                label: Text(
                  'Edit',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(width: Constants.kDefaultPadding / 2),
            
            // Toggle Complete Button
            Expanded(
              child: TextButton.icon(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  backgroundColor: task.completed 
                      ? Colors.orange.withOpacity(0.1)
                      : Colors.green.withOpacity(0.1),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  onToggleComplete();
                },
                icon: Icon(
                  task.completed ? FeatherIcons.rotateCcw : FeatherIcons.check,
                  color: task.completed ? Colors.orange : Colors.green,
                  size: 16,
                ),
                label: Text(
                  task.completed ? 'Reopen' : 'Complete',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: task.completed ? Colors.orange : Colors.green,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: Constants.kDefaultPadding / 2),
        
        // Delete Button
        TextButton.icon(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            backgroundColor: Colors.red.withOpacity(0.1),
            foregroundColor: Colors.red,
          ),
          onPressed: () {
            Navigator.of(context).pop();
            onDelete();
          },
          icon: const Icon(FeatherIcons.trash2, color: Colors.red, size: 16),
          label: Text(
            'Delete Task',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.red,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}