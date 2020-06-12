import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mylk/model/journal_model.dart';
import 'package:mylk/model/user_model.dart';

class UserState with ChangeNotifier {
  User user;

  void updateUser(User user) {
    this.user = user;
    notifyListeners();
  }
}

class JournalState with ChangeNotifier {
  Journal currentJournal;

  void updateCurrentJournal(Journal journal) {
    currentJournal = journal;
    notifyListeners();
  }
}

class JournalEntryState with ChangeNotifier {
  Map<int, int> journalEntryUpdates = {};

  void refreshJournalEntries(int id) {
    if (journalEntryUpdates[id] != null) {
      journalEntryUpdates[id]++;
    }
    notifyListeners();
  }
}
