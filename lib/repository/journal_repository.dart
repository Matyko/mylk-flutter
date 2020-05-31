import 'package:mylk/dao/journal_dao.dart';
import 'package:mylk/model/journal_model.dart';

class JournalRepository {
  final taskDao = JournalDao();

  Future getAllJournals({Map<String, dynamic> query}) => taskDao.getJournals(query: query);

  Future insertJournal(Journal task) => taskDao.createJournal(task);

  Future updateJournal(Journal task) => taskDao.updateJournal(task);

  Future deleteJournalById(int id) => taskDao.deleteJournal(id);

  Future deleteAllJournals() => taskDao.deleteAllJournals();
}
