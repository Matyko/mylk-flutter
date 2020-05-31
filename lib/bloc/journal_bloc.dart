import 'package:mylk/model/journal_model.dart';
import 'package:mylk/repository/journal_repository.dart';


import 'dart:async';

class JournalBloc {
  final _journalRepository = JournalRepository();
  final _journalController = StreamController<List<Journal>>.broadcast();
  get journals => _journalController.stream;
  Map<String, dynamic>_query;

  JournalBloc() {
    getJournals(query: _query);
  }

  getJournals({Map<String, dynamic> query}) async {
    _query = query;
    _journalController.sink.add(await _journalRepository.getAllJournals(query: query));
  }

  addJournal(Journal journal) async {
    await _journalRepository.insertJournal(journal);
    getJournals(query: _query);
  }

  updateJournal(Journal journal) async {
    await _journalRepository.updateJournal(journal);
    getJournals(query: _query);
  }

  deleteJournalById(int id) async {
    _journalRepository.deleteJournalById(id);
    getJournals(query: _query);
  }

  dispose() {
    _journalController.close();
  }
}