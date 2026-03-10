import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/task_model.dart';

class TaskService {
  final Dio dio = Dio();

  final String baseUrl =
      "https://test-app-d7e14-default-rtdb.firebaseio.com/tasks";

  String get userId => FirebaseAuth.instance.currentUser!.uid;

  Future<List<Task>> fetchTasks() async {
    final response = await dio.get("$baseUrl/$userId.json");

    if (response.data == null) {
      return [];
    }

    Map data = response.data;

    List<Task> tasks = [];

    data.forEach((key, value) {
      tasks.add(Task.fromJson(key, value));
    });

    return tasks;
  }

  Future<void> addTask(String title, String description) async {
    await dio.post(
      "$baseUrl/$userId.json",
      data: {
        "title": title,
        "description": description,
        "completed": false
      },
    );
  }

  Future<void> deleteTask(String id) async {
    await dio.delete("$baseUrl/$userId/$id.json");
  }

  Future<void> updateTask(Task task) async {
    await dio.patch(
      "$baseUrl/$userId/${task.id}.json",
      data: task.toJson(),
    );
  }
}