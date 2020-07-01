class Task {
  int id;
  String title;
  DateTime due;
  bool isDone;
  DateTime createdAt;
  DateTime modifiedAt;
  DateTime doneAt;
  int priority;
  int notificationId;

  Task({this.id, this.title, this.due, this.isDone, this.createdAt, this.modifiedAt, this.doneAt, this.priority, this.notificationId});

  factory Task.fromDatabaseJson(Map<String, dynamic> data) => Task(
    id: data['id'],
    title: data['title'],
    due: data['due'] != null ? DateTime.fromMillisecondsSinceEpoch(data['due']) : null,
    priority: data['priority'],
    isDone: data['is_done'] == 0 ? false : true,
    createdAt: DateTime.fromMillisecondsSinceEpoch(data['created_at']),
    modifiedAt: data["modified_at"] != null ? DateTime.fromMillisecondsSinceEpoch(data['modified_at']) : null,
    doneAt: data["done_at"] != null ? DateTime.fromMillisecondsSinceEpoch(data['done_at']) : null,
    notificationId: data["notification_id"]
  );

  Map<String, dynamic> toDatabaseJson() => {
    "id": this.id,
    "title": this.title,
    "due": this.due != null ? this.due.millisecondsSinceEpoch : null,
    "is_done": this.isDone == true ? 1 : 0,
    "created_at": this.createdAt.millisecondsSinceEpoch,
    "priority": this.priority,
    "modified_at": this.modifiedAt != null ? this.modifiedAt.millisecondsSinceEpoch : null,
    "done_at": this.doneAt != null ? this.doneAt.millisecondsSinceEpoch : null,
    "notification_id": this.notificationId
  };
}

final List<Task> tasks = [];
