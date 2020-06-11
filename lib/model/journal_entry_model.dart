import 'mood_model.dart';

class JournalEntry {
  int id;
  int journalId;
  String title;
  String content;
  Mood mood;
  DateTime createdAt;
  DateTime modifiedAt;

  JournalEntry({this.id, this.journalId, this.title, this.content, this.createdAt, this.modifiedAt, this.mood});

  factory JournalEntry.fromDatabaseJson(Map<String, dynamic> data) => JournalEntry(
      id: data['id'],
      journalId: data['journal_id'],
      content: data['content'],
      title: data['title'],
      mood: baseMoods.firstWhere((mood) => mood.id == data['mood_id']),
      createdAt: DateTime.fromMillisecondsSinceEpoch(data['created_at']),
      modifiedAt: data["modified_at"] != null ? DateTime.fromMillisecondsSinceEpoch(data['modified_at']) : null,
  );

  Map<String, dynamic> toDatabaseJson() => {
    "id": this.id,
    "journal_id": this.journalId,
    "title": this.title,
    "content": this.content,
    "mood_id": this.mood.id,
    "created_at": this.createdAt.millisecondsSinceEpoch,
    "modified_at": this.modifiedAt != null ? this.modifiedAt.millisecondsSinceEpoch : null
  };
}
