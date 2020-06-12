import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mylk/bloc/journal_entry_bloc.dart';
import 'package:mylk/bloc/task_bloc.dart';
import 'package:mylk/widgets/entry_chart.dart';
import 'package:mylk/widgets/mood_chart.dart';
import 'package:mylk/widgets/mood_entry_chart.dart';
import 'package:mylk/widgets/task_chart.dart';
import 'package:mylk/widgets/sum_widget.dart';

List<StaggeredTile> _staggeredTiles = const <StaggeredTile>[
  StaggeredTile.count(1, 1),
  StaggeredTile.count(1, 1),
  StaggeredTile.count(2, 1),
  StaggeredTile.count(1, 1),
  StaggeredTile.count(1, 1),
  StaggeredTile.count(2, 1)
];

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({Key key}) : super(key: key);

  @override
  _StatisticsScreenState createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  bool _visible = false;
  @override
  Widget build(BuildContext context) {
    final JournalEntryBloc _journalEntryBloc = JournalEntryBloc();
    final TaskBloc _taskBloc = TaskBloc();
    _journalEntryBloc.getJournalEntries();
    _taskBloc.getTasks(query: {"orderBy": "+created_at"});
    if (!_visible) {
      Future.delayed(Duration(milliseconds: 100), () {
        if (!mounted) return;
        setState(() {
          _visible = true;
        });
      });
    }
    return new Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: new StaggeredGridView.count(
              crossAxisCount: 2,
              staggeredTiles: _staggeredTiles,
              children: <Widget>[
                StreamBuilder(
                    stream: _journalEntryBloc.journalEntries,
                    builder: (context, snapshot) {
                      return SumWidget(snapshot.data != null ? snapshot.data.length : 0, "Entries");
                    }
                ),
                StreamBuilder(
                    stream: _taskBloc.tasks,
                    builder: (context, snapshot) {
                      return SumWidget(snapshot.data != null ? snapshot.data.length : 0, "Tasks");
                    }
                ),
                StreamBuilder(
                  stream: _journalEntryBloc.journalEntries,
                  builder: (context, snapshot) {
                    return (snapshot != null && snapshot.data != null) ? MoodChart(snapshot.data) : Container();
                  }
                ),
                StreamBuilder(
                    stream: _journalEntryBloc.journalEntries,
                    builder: (context, snapshot) {
                      return (snapshot != null && snapshot.data != null) ? EntryChart(snapshot.data) : Container();
                    }
                ),
                StreamBuilder(
                    stream: _taskBloc.tasks,
                    builder: (context, snapshot) {
                      return (snapshot != null && snapshot.data != null) ? TaskChart(snapshot.data) : Container();
                    }
                ),
                StreamBuilder(
                    stream: _journalEntryBloc.journalEntries,
                    builder: (context, snapshot) {
                      return (snapshot != null && snapshot.data != null) ? MoodEntryChart(snapshot.data) : Container();
                    }
                )
              ],
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
              padding: const EdgeInsets.all(4.0),
            ),
          ),
        ));
  }
}
