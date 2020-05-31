import 'package:mylk/model/journal_entry_model.dart';
import 'package:mylk/repository/journal_entry_repository.dart';


import 'dart:async';

class JournalEntryBloc {
  final _journalEntryRepository = JournalEntryRepository();
  final _journalEntryController = StreamController<List<JournalEntry>>.broadcast();
  get journalEntries => _journalEntryController.stream;
  Map<String, dynamic>_query;

  JournalEntryBloc() {
    getJournalEntrys(query: _query);
  }

  getJournalEntrys({Map<String, dynamic> query}) async {
    _query = query;
    _journalEntryController.sink.add(await _journalEntryRepository.getAllJournalEntries(query: query));
  }

  addJournalEntry(JournalEntry journalEntry) async {
    await _journalEntryRepository.insertJournalEntry(journalEntry);
    getJournalEntrys(query: _query);
  }

  updateJournalEntry(JournalEntry journalEntry) async {
    await _journalEntryRepository.updateJournalEntry(journalEntry);
    getJournalEntrys(query: _query);
  }

  deleteJournalEntryById(int id) async {
    _journalEntryRepository.deleteJournalEntryById(id);
    getJournalEntrys(query: _query);
  }

  dispose() {
    _journalEntryController.close();
  }
}