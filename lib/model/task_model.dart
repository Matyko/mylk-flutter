class Task {
  int id;
  String title;
  DateTime due;
  bool isDone;
  DateTime createdAt;
  DateTime modifiedAt;

  Task({this.id, this.title, this.due, this.isDone});
  
  factory Task.fromDatabaseJson(Map<String, dynamic> data) => Task(
    id: data['id'],
    title: data['title'],
    due: DateTime.parse(data['due']),
    isDone: data['is_done'] == 0 ? false : true
  );

  Map<String, dynamic> toDatabaseJson() => {
    "id": this.id,
    "title": this.title,
    "due": this.due.toIso8601String(),
    "is_done": this.isDone == true ? 1 : 0
  };
}

final List<Task> tasks = [];