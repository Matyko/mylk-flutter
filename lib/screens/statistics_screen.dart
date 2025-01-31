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
  StaggeredTile.count(1, 1),
  StaggeredTile.count(1, 1),
  StaggeredTile.count(2, 1),
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
    _journalEntryBloc.getJournalEntries(query: {"orderBy": "+date"});
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
        extendBody: true,
        body: SafeArea(
          child: new StaggeredGridView.count(
            crossAxisCount: 2,
            staggeredTiles: _staggeredTiles,
            children: <Widget>[
              StreamBuilder(
                  stream: _journalEntryBloc.journalEntries,
                  builder: (context, snapshot) {
                    return Card(child: SumWidget(snapshot.data != null ? snapshot.data.length : 0, "Entries"));
                  }
              ),
              StreamBuilder(
                  stream: _taskBloc.tasks,
                  builder: (context, snapshot) {
                    return Card(child: SumWidget(snapshot.data != null ? snapshot.data.length : 0, "Tasks"));
                  }
              ),
              StreamBuilder(
                  stream: _journalEntryBloc.journalEntries,
                  builder: (context, snapshot) {
                    return (snapshot != null && snapshot.data != null) ? Card(child: EntryChart(snapshot.data)) : Container();
                  }
              ),
              StreamBuilder(
                  stream: _taskBloc.tasks,
                  builder: (context, snapshot) {
                    return (snapshot != null && snapshot.data != null) ? Card(child: TaskChart(snapshot.data)) : Container();
                  }
              ),
              StreamBuilder(
                  stream: _journalEntryBloc.journalEntries,
                  builder: (context, snapshot) {
                    return (snapshot != null && snapshot.data != null) ? Card(child: MoodChart(snapshot.data)) : Container();
                  }
              ),
              StreamBuilder(
                  stream: _journalEntryBloc.journalEntries,
                  builder: (context, snapshot) {
                    return (snapshot != null && snapshot.data != null) ? Card(child: MoodEntryChart(snapshot.data)) : Container();
                  }
              ),
              Container()
            ],
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0,
            padding: const EdgeInsets.all(4.0),
          ),
        ));
  }
}
