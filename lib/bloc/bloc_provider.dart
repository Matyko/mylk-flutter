import 'package:flutter/material.dart';
import 'package:mylk/bloc/journal_entry_bloc.dart';
import 'package:mylk/bloc/task_bloc.dart';
import 'package:mylk/bloc/theme_bloc.dart';
import 'package:mylk/bloc/user_bloc.dart';
import 'journal_bloc.dart';

class BlocProvider extends InheritedWidget {
  const BlocProvider({
    Key key,
    @required this.taskBloc,
    @required this.journalBloc,
    @required this.journalEntryBloc,
    @required this.userBloc,
    @required this.themeBloc,
    @required Widget child,
  })  : assert(taskBloc != null),
        assert(child != null),
        super(key: key, child: child);

  final TaskBloc taskBloc;
  final JournalBloc journalBloc;
  final JournalEntryBloc journalEntryBloc;
  final UserBloc userBloc;
  final ThemeBloc themeBloc;

  static BlocProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<BlocProvider>();
  }

  @override
  bool updateShouldNotify(BlocProvider oldWidget) {
    return true;
  }
}
