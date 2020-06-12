import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:mylk/bloc/bloc_provider.dart';
import 'package:mylk/bloc/journal_bloc.dart';
import 'package:mylk/bloc/journal_entry_bloc.dart';
import 'package:mylk/bloc/task_bloc.dart';
import 'package:mylk/bloc/theme_bloc.dart';
import 'package:mylk/bloc/user_bloc.dart';
import 'package:mylk/state/global_state.dart';
import 'package:mylk/widgets/navigation_controller.dart';
import 'package:provider/provider.dart';

import 'model/theme_model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
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
            themeBloc: ThemeBloc(),
            child: MylkApp()),
      ),
    ),
  ));
}

class MylkApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserBloc themeBloc = BlocProvider.of(context).userBloc;
    return StreamBuilder(
        stream: themeBloc.user,
        builder: (context, snapshot) {
          return MaterialApp(
            title: 'Mylk',
            debugShowCheckedModeBanner: false,
            home: NavigationController(),
            theme: snapshot.data != null && snapshot.data.themeId != null
                ? themes
                    .firstWhere((element) => element.id == snapshot.data.themeId).themeData
                : themes[0].themeData,
          );
        });
  }
}
