class User {
  int id;
  DateTime createdAt;
  DateTime modifiedAt;
  String email;
  String name;
  int themeId;

  User({this.id, this.createdAt, this.modifiedAt, this.name, this.email, this.themeId});

  factory User.fromDatabaseJson(Map<String, dynamic> data) => User(
    id: data['id'],
    name: data['name'],
    email: data['email'],
    themeId: data['theme_id'],
    createdAt: DateTime.fromMillisecondsSinceEpoch(data['created_at']),
    modifiedAt: data["modified_at"] != null ? DateTime.fromMillisecondsSinceEpoch(data['modified_at']) : null,
  );

  Map<String, dynamic> toDatabaseJson() => {
    "id": this.id,
    "name": this.name,
    "email": this.email,
    "created_at": this.createdAt.millisecondsSinceEpoch,
    "theme_id": this.themeId,
    "modified_at": this.modifiedAt != null ? this.modifiedAt.millisecondsSinceEpoch : null
  };
}