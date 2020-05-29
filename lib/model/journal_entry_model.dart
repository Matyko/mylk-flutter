import 'package:mylk/model/task_model.dart';

class JournalEntry {
  String title;
  String content;
  DateTime createdAt;
  DateTime modifiedAt;
  List<Task> tasks;

  JournalEntry(this.title, this.content);
}

final List<JournalEntry> journalEntries = [];