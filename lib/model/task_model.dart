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
    due: DateTime.fromMillisecondsSinceEpoch(data['due']),
    isDone: data['is_done'] == 0 ? false : true,
    createdAt: DateTime.fromMillisecondsSinceEpoch(data['created_at']),
    modifiedAt: data["modified_at"] != null ? DateTime.fromMillisecondsSinceEpoch(data['modified_at']) : null,
  );

  Map<String, dynamic> toDatabaseJson() => {
    "id": this.id,
    "title": this.title,
    "due": this.due.millisecondsSinceEpoch,
    "is_done": this.isDone == true ? 1 : 0,
    "created_at": this.createdAt.millisecondsSinceEpoch,
    "modified_at": this.modifiedAt != null ? this.modifiedAt.millisecondsSinceEpoch : null
  };
}

final List<Task> tasks = [];