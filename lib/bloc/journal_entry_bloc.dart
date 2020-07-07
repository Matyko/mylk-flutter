import 'package:mylk/model/journal_entry_model.dart';
import 'package:mylk/repository/journal_entry_repository.dart';


import 'dart:async';

class JournalEntryBloc {
  final _journalEntryRepository = JournalEntryRepository();
  final _journalEntryController = StreamController<List<JournalEntry>>.broadcast();
  get journalEntries => _journalEntryController.stream;
  Map<String, dynamic>_query;

  JournalEntryBloc() {
    getJournalEntries(query: _query);
  }

  getJournalEntries({Map<String, dynamic> query}) async {
    _query = query;
    _journalEntryController.sink.add(await _journalEntryRepository.getAllJournalEntries(query: query));
  }

  addJournalEntry(JournalEntry journalEntry) async {
    await _journalEntryRepository.insertJournalEntry(journalEntry);
    getJournalEntries(query: _query);
  }

  updateJournalEntry(JournalEntry journalEntry) async {
    await _journalEntryRepository.updateJournalEntry(journalEntry);
    getJournalEntries(query: _query);
  }

  deleteJournalEntryById(int id) async {
    _journalEntryRepository.deleteJournalEntryById(id);
    getJournalEntries(query: _query);
  }

  dispose() {
    _journalEntryController.close();
  }
}
