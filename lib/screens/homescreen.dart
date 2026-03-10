import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/constants/app_colors.dart';
import 'package:todo_app/providers/auth_provider.dart';
import 'package:todo_app/providers/task_provider.dart';
import 'package:todo_app/screens/onboardscreen.dart';
import 'package:todo_app/widgets/dialogue.dart';
import 'package:todo_app/widgets/task_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<TaskProvider>(context, listen: false).loadTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final taskProvider = Provider.of<TaskProvider>(context);

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.white,

      appBar: AppBar(
  backgroundColor: AppColors.primary,
  elevation: 0,
  automaticallyImplyLeading: false,
  title: const Text(
    "MinimalDo",
    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
  ),
  actions: [
    IconButton(
      icon: const Icon(Icons.logout, color: Colors.white),
      onPressed: () {
        showConfirmDialog(
          context: context,
          title: "Logout",
          message: "Are you sure you want to logout?",
          confirmText: "Logout",
          onConfirm: () async {
            await authProvider.logout();

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const OnboardScreen()),
            );
          },
        );
      },
    ),
  ],
),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.05),

        child: Column(
          children: [
            SizedBox(height: height * 0.006),

            // Empty
            Expanded(
              child: taskProvider.tasks.isEmpty
                  ? const Center(
                      child: Text(
                        "No Tasks Yet",
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: taskProvider.tasks.length,

                      itemBuilder: (context, index) {
                        final task = taskProvider.tasks[index];

                        return Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: height * 0.01,
                          ),
                          child: TaskTile(task: task),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: Colors.white),

        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,

            builder: (_) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),

                child: Container(
                  padding: EdgeInsets.all(width * 0.05),

                  child: Column(
                    mainAxisSize: MainAxisSize.min,

                    // Add Task Card
                    children: [
                      Text(
                        "Add Task",
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
                            await taskProvider.addTask(
                              titleController.text,
                              descriptionController.text,
                            );

                            titleController.clear();
                            descriptionController.clear();

                            Navigator.pop(context);
                          },

                          child: const Text(
                            "Add Task",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),

                      SizedBox(height: height * 0.01),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
