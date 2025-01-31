class Journal {
  int id;
  String title;
  String backgroundImagePath;
  DateTime createdAt;
  DateTime modifiedAt;

  Journal({this.id, this.title, this.backgroundImagePath, this.createdAt, this.modifiedAt});

  factory Journal.fromDatabaseJson(Map<String, dynamic> data) => Journal(
      id: data['id'],
      title: data['title'],
      backgroundImagePath: data['background_image'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(data['created_at']),
      modifiedAt: data["modified_at"] != null ? DateTime.fromMillisecondsSinceEpoch(data['modified_at']) : null
  );

  Map<String, dynamic> toDatabaseJson() => {
    "id": this.id,
    "title": this.title,
    "background_image": this.backgroundImagePath,
    "created_at": this.createdAt.millisecondsSinceEpoch,
    "modified_at": this.modifiedAt != null ? this.modifiedAt.millisecondsSinceEpoch : null
  };
}
