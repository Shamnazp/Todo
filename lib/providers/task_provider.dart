import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../services/task_service.dart';

class TaskProvider extends ChangeNotifier {
  final TaskService service = TaskService();

  List<Task> tasks = [];

  Future<void> loadTasks() async {
    tasks = await service.fetchTasks();
    notifyListeners();
  }

  Future<void> addTask(String title, String description) async {
    await service.addTask(title, description);
    await loadTasks();
  }

  Future<void> deleteTask(String id) async {
    await service.deleteTask(id);
    await loadTasks();
  }

  Future<void> toggleTask(Task task) async {
    final updated = Task(
      id: task.id,
      title: task.title,
      description: task.description,
      completed: !task.completed,
    );

    await service.updateTask(updated);
    await loadTasks();
  }

  Future<void> updateTask(Task task) async {
    await service.updateTask(task);
    await loadTasks();
  }
}
