class Task {
  final String id;
  final String title;
  final bool completed;
  final String userId;

  Task({
    required this.id,
    required this.title,
    required this.completed,
    required this.userId,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      completed: json['completed'] ?? json['isCompleted'] ?? false,
      userId: json['userId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'completed': completed,
        'userId': userId,
      };
}
