class Task {
  int id;
  String title;
  DateTime due;
  bool isDone;
  DateTime createdAt;
  DateTime modifiedAt;

  Task({this.id, this.title, this.due, this.isDone, this.createdAt, this.modifiedAt});
  
  factory Task.fromDatabaseJson(Map<String, dynamic> data) => Task(
    id: data['id'],
    title: data['title'],
    due: DateTime.parse(data['due']),
    isDone: data['is_done'] == 0 ? false : true,
    createdAt: DateTime.parse(data['created_at']),
    modifiedAt: data["modified_at"] != null ? DateTime.parse(data['modified_at']) : null,
  );

  Map<String, dynamic> toDatabaseJson() => {
    "id": this.id,
    "title": this.title,
    "due": this.due.toIso8601String(),
    "is_done": this.isDone == true ? 1 : 0,
    "created_at": this.createdAt.toIso8601String(),
    "modified_at": this.modifiedAt != null ? this.modifiedAt.toIso8601String() : null
  };
}

final List<Task> tasks = [];