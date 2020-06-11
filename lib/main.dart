import 'package:flutter/material.dart';
import 'package:mylk/bloc/bloc_provider.dart';
import 'package:mylk/bloc/journal_bloc.dart';
import 'package:mylk/bloc/journal_entry_bloc.dart';
import 'package:mylk/bloc/task_bloc.dart';
import 'package:mylk/bloc/user_bloc.dart';
import 'package:mylk/state/global_state.dart';
import 'package:mylk/widgets/navigation_controller.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ChangeNotifierProvider<JournalState>(
    create: (context) => JournalState(),
    child: ChangeNotifierProvider<UserState>(
      create: (context) => UserState(),
      child: ChangeNotifierProvider<JournalEntryState>(
        create: (context) => JournalEntryState(),
        child: BlocProvider(
            taskBloc: TaskBloc(),
            journalEntryBloc: JournalEntryBloc(),
            journalBloc: JournalBloc(),
            userBloc: UserBloc(),
            child: MylkApp()),
      ),
    ),
  ));
}

class MylkApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mylk',
      debugShowCheckedModeBanner: false,
      home: NavigationController(),
      theme: ThemeData(
          primaryColor: Colors.teal.shade400,
          backgroundColor: Colors.teal.shade200,
          fontFamily: 'Quicksand',
          textTheme:
              TextTheme(headline6: TextStyle(fontWeight: FontWeight.bold))),
    );
  }
}
