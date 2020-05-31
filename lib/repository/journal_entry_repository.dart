import 'package:mylk/dao/journal_entry_dao.dart';
import 'package:mylk/model/journal_entry_model.dart';

class JournalEntryRepository {
  final taskDao = JournalEntryDao();

  Future getAllJournalEntries({Map<String, dynamic> query}) => taskDao.getJournalEntries(query: query);

  Future insertJournalEntry(JournalEntry task) => taskDao.createJournalEntry(task);

  Future updateJournalEntry(JournalEntry task) => taskDao.updateJournalEntry(task);

  Future deleteJournalEntryById(int id) => taskDao.deleteJournalEntry(id);

  Future deleteAllJournalEntries() => taskDao.deleteAllJournalEntries();
}
