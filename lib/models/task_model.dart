class Task {
  final String id;
  final String title;
  final String description;
  final bool completed;

  Task({
    required this.id,
    required this.title,
    required this.description,
    this.completed = false,
  });

  factory Task.fromJson(String id, Map data) {
    return Task(
      id: id,
      title: data['title'],
      description: data['description'],
      completed: data['completed'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {"title": title, "description": description, "completed": completed};
  }
}
