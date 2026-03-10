import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/constants/app_colors.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/providers/task_provider.dart';

class EditTaskSheet extends StatefulWidget {
  final Task task;

  const EditTaskSheet({super.key, required this.task});

  @override
  State<EditTaskSheet> createState() => _EditTaskSheetState();
}

class _EditTaskSheetState extends State<EditTaskSheet> {

  late TextEditingController titleController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();

    titleController = TextEditingController(text: widget.task.title);
    descriptionController =
        TextEditingController(text: widget.task.description);
  }

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<TaskProvider>(context, listen: false);

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),

      child: Container(
        padding: EdgeInsets.all(width * 0.05),

        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            Text(
              "Edit Task",
              style: TextStyle(
                fontSize: width * 0.045,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),

            SizedBox(height: height * 0.02),

            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: "Task Title",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: height * 0.02),

            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: "Task Description",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: height * 0.02),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                ),

                onPressed: () async {

                  final updatedTask = Task(
                    id: widget.task.id,
                    title: titleController.text,
                    description: descriptionController.text,
                    completed: widget.task.completed,
                  );

                  await provider.updateTask(updatedTask);

                  Navigator.pop(context);
                },

                child: const Text(
                  "Update Task",
                  style: TextStyle(color: Colors.white,fontSize: 16),
                ),
              ),
            ),

            SizedBox(height: height * 0.01),
          ],
        ),
      ),
    );
  }
}