import 'package:mylk/model/journal_entry_model.dart';

class Journal {
  String title;
  List<JournalEntry> journalEntries;
  DateTime createdAt;
  DateTime modifiedAt;
  String backGroundImage;

  Journal(this.title, this.journalEntries, this.backGroundImage);
}

List<JournalEntry> journalEntries = [
  JournalEntry(
      "test journal entry 1",
      "test content ......"
  ),
  JournalEntry(
      "test journal entry 2",
      "test content ......"
  )
];


List<Journal> journals = [
  Journal(
      "test journal 1",
      journalEntries,
      "bg-1"
  ),
  Journal(
      "test journal 2",
      journalEntries,
      "bg-2"
  ),
  Journal(
      "test journal 2",
      journalEntries,
      "bg-3"
  ),
];