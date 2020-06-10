import 'package:flutter/foundation.dart';
import 'package:mylk/model/journal_model.dart';
import 'package:mylk/model/user_model.dart';

class GlobalState with ChangeNotifier {
  Journal currentJournal;
  User user;

  void updateUser(User user) {
    this.user = user;
    notifyListeners();
  }

  void updateCurrentJournal(Journal journal) {
    currentJournal = journal;
    notifyListeners();
  }
}