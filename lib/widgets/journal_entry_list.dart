import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mylk/bloc/bloc_provider.dart';
import 'package:mylk/bloc/journal_entry_bloc.dart';
import 'package:mylk/model/journal_entry_model.dart';
import 'package:mylk/model/journal_model.dart';
import 'package:mylk/screens/journal_entry_form_screen.dart';

class JournalEntryList extends StatefulWidget {
  final Journal journal;
  final int limit;

  const JournalEntryList(this.journal, this.limit);

  @override
  _JournalEntryListState createState() => _JournalEntryListState();
}

class _JournalEntryListState extends State<JournalEntryList> {
  JournalEntryBloc _journalEntryBloc;

  @override
  Widget build(BuildContext context) {
    _journalEntryBloc = BlocProvider.of(context).journalEntryBloc;
    if (widget.journal != null) {
      _journalEntryBloc.getJournalEntries(query: {
        "where": "journal_id = ?",
        "args": [widget.journal.id],
        "limit": widget.limit
      });
    } else {
      _journalEntryBloc.getJournalEntries();
    }
    return StreamBuilder(
      stream: _journalEntryBloc.journalEntries,
      builder:
          (BuildContext context, AsyncSnapshot<List<JournalEntry>> snapshot) {
        List<Widget> list = new List<Widget>();
        if (snapshot != null &&
            snapshot.data != null &&
            snapshot.data.length != 0) {
          snapshot.data.forEach((journalEntry) {
            list.add(ListTile(
              title: Text(journalEntry.title != null ? journalEntry.title : ""),
              subtitle: Text(
                  journalEntry.content != null ? journalEntry.content : ""),
            ));
          });
        }
        list.add(ListTile(
            leading: FaIcon(FontAwesomeIcons.plusCircle),
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => JournalEntryFormScreen(
                        null, this.widget.journal.id)))));
        return ListView(
          shrinkWrap: true,
          children: list,
        );
      },
    );
  }
}
