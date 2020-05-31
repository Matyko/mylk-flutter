import 'package:flutter/material.dart';
import 'package:mylk/bloc/bloc_provider.dart';
import 'package:mylk/bloc/journal_bloc.dart';
import 'package:mylk/bloc/journal_entry_bloc.dart';
import 'package:mylk/bloc/task_bloc.dart';
import 'package:mylk/widgets/navigation_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(BlocProvider(
      taskBloc: TaskBloc(),
      journalEntryBloc: JournalEntryBloc(),
      journalBloc: JournalBloc(),
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mylk',
      debugShowCheckedModeBanner: false,
      home: NavigationController(),
      theme: ThemeData(
          primaryColor: Colors.teal,
          backgroundColor: Colors.grey[300],
          textTheme:
              TextTheme(headline6: TextStyle(fontWeight: FontWeight.bold))),
    );
  }
}
