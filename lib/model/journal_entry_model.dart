class JournalEntry {
  int id;
  int journalId;
  String title;
  String content;
  DateTime createdAt;
  DateTime modifiedAt;

  JournalEntry({this.id, this.journalId, this.title, this.content, this.createdAt, this.modifiedAt});

  factory JournalEntry.fromDatabaseJson(Map<String, dynamic> data) => JournalEntry(
      id: data['id'],
      journalId: data['joutnal_id'],
      title: data['title'],
      content: data['content'],
      createdAt: DateTime.parse(data['created_at']),
      modifiedAt: data["modified_at"] != null ? DateTime.parse(data['modified_at']) : null,
  );

  Map<String, dynamic> toDatabaseJson() => {
    "id": this.id,
    "joutnal_id": this.journalId,
    "title": this.title,
    "content": this.content,
    "created_at": this.createdAt.toIso8601String(),
    "modified_at": this.modifiedAt != null ? this.modifiedAt.toIso8601String() : null
  };
}

final List<JournalEntry> journalEntries = [];
