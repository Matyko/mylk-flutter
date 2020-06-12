import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mylk/bloc/journal_entry_bloc.dart';
import 'package:mylk/model/journal_entry_model.dart';
import 'package:mylk/model/journal_model.dart';
import 'package:mylk/screens/journal_entry_form_screen.dart';
import 'package:mylk/state/global_state.dart';
import 'package:provider/provider.dart';

class JournalEntryList extends StatefulWidget {
  final Journal journal;
  final int limit;

  const JournalEntryList(this.journal, this.limit);

  @override
  _JournalEntryListState createState() => _JournalEntryListState();
}

class _JournalEntryListState extends State<JournalEntryList> {
  JournalEntryBloc _journalEntryBloc;
  int _currentWidgetId;
  DateTime _currentDate;
  int _currentVersion = 0;

  @override
  void initState() {
    _journalEntryBloc = JournalEntryBloc();
    _currentWidgetId = widget.journal != null ? widget.journal.id : null;
    loadData();
    if (_currentWidgetId != null) {
      Provider.of<JournalEntryState>(context, listen: false).journalEntryUpdates[_currentWidgetId] = 0;
    }
    super.initState();
  }

  void loadData() {
    if (widget.journal != null) {
      _journalEntryBloc.getJournalEntries(query: {
        "where": "journal_id = ?",
        "args": [widget.journal.id],
        "limit": widget.limit
      });
    } else {
      _journalEntryBloc.getJournalEntries();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.journal != null && widget.journal.id != _currentWidgetId) {
      _currentWidgetId = widget.journal.id;
      loadData();
    }
    return Consumer<JournalEntryState>(
      builder: (context, model, otherWidget) => StreamBuilder(
        stream: _journalEntryBloc.journalEntries,
        builder:
            (BuildContext context, AsyncSnapshot<List<JournalEntry>> snapshot) {
          List<Widget> list = new List<Widget>();
          _currentDate = null;
          if (widget.journal != null && widget.journal.id != null && model.journalEntryUpdates[widget.journal.id] != null && model.journalEntryUpdates[widget.journal.id] > _currentVersion) {
            _currentVersion = model.journalEntryUpdates[widget.journal.id];
            loadData();
          }
          if (snapshot != null &&
              snapshot.data != null &&
              snapshot.data.length != 0) {
            snapshot.data.forEach((journalEntry) {
              if (_currentDate == null
                  || _currentDate.year != journalEntry.createdAt.year
                  || _currentDate.month != journalEntry.createdAt.month
                  || _currentDate.day != journalEntry.createdAt.day
              ) {
                _currentDate = journalEntry.createdAt;
                list.add(ListTile(
                  title: Text(DateFormat('yyyy.MM.dd').format(journalEntry.createdAt))
                ));
              }
              list.add(Dismissible(
                background: Container(
                  color: Theme.of(context).primaryColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ListTile(
                        leading: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            FaIcon(
                              FontAwesomeIcons.pencilAlt,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                secondaryBackground: Container(
                  color: Colors.red,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ListTile(
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            FaIcon(
                              FontAwesomeIcons.trashAlt,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                confirmDismiss: (DismissDirection direction) async {
                  if (direction == DismissDirection.startToEnd) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => JournalEntryFormScreen(journalEntry, widget.journal, loadData)));
                    return false;
                  } else {
                    return await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Confirm"),
                          content: const Text(
                              "Are you sure you wish to delete this item?"),
                          actions: <Widget>[
                            FlatButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(true),
                                child: const Text("DELETE")),
                            FlatButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: const Text("CANCEL"),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                onDismissed: (DismissDirection direction) {
                  _journalEntryBloc.deleteJournalEntryById(journalEntry.id);
                },
                key: Key(journalEntry.id.toString()),
                child: ListTile(
                  title: Text(journalEntry.title != null ? journalEntry.title : ""),
                  subtitle: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          journalEntry.content != null ? journalEntry.content : ""),
                    ),
                  ),
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      FaIcon(journalEntry.mood.icon),
                      Text(DateFormat('kk:mm').format(journalEntry.createdAt), textAlign: TextAlign.right,)
                    ],
                  ),
                ),
              ));
            });
          }
          return ListView(
            padding: EdgeInsets.only(bottom: 20.0),
            shrinkWrap: true,
            children: list,
          );
        },
      ),
    );
  }
}
