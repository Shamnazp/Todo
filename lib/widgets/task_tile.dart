import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/widgets/dialogue.dart';
import 'package:todo_app/widgets/edit_task.dart';
import '../constants/app_colors.dart';
import '../models/task_model.dart';
import '../providers/task_provider.dart';

class TaskTile extends StatelessWidget {
  final Task task;

  const TaskTile({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TaskProvider>(context, listen: false);
    return Card(
      color: AppColors.primary,
      elevation: 2,
      margin: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.height * 0.002,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),

      child: ListTile(
        leading: Checkbox(
          value: task.completed,
          side: const BorderSide(color: AppColors.white, width: 2),
          activeColor: AppColors.white,
          checkColor: AppColors.primary,

          onChanged: (_) {
            provider.toggleTask(task);
          },
        ),

        // Card Section
        title: Text(
          task.title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Colors.white,
          ),
        ),

        subtitle: Text(
          task.description,
          style: TextStyle(color: Colors.grey[400],fontSize: 12,),
        ),

        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              color: AppColors.white,
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (_) => EditTaskSheet(task: task),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              color: AppColors.white,
              onPressed: () {
                showConfirmDialog(
                  context: context,
                  title: "Delete Task",
                  message: "Are you sure you want to delete this task?",
                  confirmText: "Delete",
                  onConfirm: () {
                    provider.deleteTask(task.id);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
