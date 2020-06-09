import 'package:flutter/foundation.dart';
import 'package:mylk/model/journal_model.dart';

class GlobalState with ChangeNotifier {
  Journal currentJournal;

  void updateCurrentJournal(Journal journal) {
    currentJournal = journal;
    notifyListeners();
  }
}