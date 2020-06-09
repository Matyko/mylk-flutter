class Journal {
  int id;
  String title;
  String backgroundImage;
  DateTime createdAt;
  DateTime modifiedAt;

  Journal({this.id, this.title, this.backgroundImage, this.createdAt, this.modifiedAt});

  factory Journal.fromDatabaseJson(Map<String, dynamic> data) => Journal(
      id: data['id'],
      title: data['title'],
      backgroundImage: data['background_image'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(data['created_at']),
      modifiedAt: data["modified_at"] != null ? DateTime.fromMillisecondsSinceEpoch(data['modified_at']) : null,
  );

  Map<String, dynamic> toDatabaseJson() => {
    "id": this.id,
    "title": this.title,
    "background_image": this.backgroundImage,
    "created_at": this.createdAt.millisecondsSinceEpoch,
    "modified_at": this.modifiedAt != null ? this.modifiedAt.millisecondsSinceEpoch : null
  };
}


List<Journal> journals = [];