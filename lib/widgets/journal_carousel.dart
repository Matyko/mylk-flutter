import 'package:flutter/material.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';
import 'package:mylk/bloc/bloc_provider.dart';
import 'package:mylk/bloc/journal_bloc.dart';
import 'package:mylk/bloc/journal_entry_bloc.dart';
import 'package:mylk/model/journal_entry_model.dart';
import 'package:mylk/model/journal_model.dart';
import 'package:mylk/screens/journal_screen.dart';

import 'journal_illustration.dart';

class JournalCarousel extends StatefulWidget {
  @override
  _JournalCarouselState createState() => _JournalCarouselState();
}

class _JournalCarouselState extends State<JournalCarousel> {
  LinkedScrollControllerGroup _controllers;
  ScrollController _journalScrollController;
  ScrollController _entryGroupsScrollController;
  JournalBloc _journalBloc;
  JournalEntryBloc _journalEntryBloc;

  @override
  void initState() {
    super.initState();
    _controllers = LinkedScrollControllerGroup();
    _journalScrollController = _controllers.addAndGet();
    _entryGroupsScrollController = _controllers.addAndGet();
  }

  @override
  void dispose() {
    _journalScrollController.dispose();
    _entryGroupsScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double offset = MediaQuery.of(context).size.width * 0.2;
    _journalBloc = BlocProvider.of(context).journalBloc;
    _journalEntryBloc = BlocProvider.of(context).journalEntryBloc;
    _journalBloc.getJournals();
    _journalEntryBloc.getJournalEntries();
    return Container(
        height: 300.0,
        child: StreamBuilder(
            stream: _journalBloc.journals,
            builder: (BuildContext context,
                AsyncSnapshot<List<Journal>> snapshot) {
              List<Widget> list = new List<Widget>();
              if (snapshot != null &&
                  snapshot.data != null &&
                  snapshot.data.length != 0) {
                snapshot.data.forEach((journal) {
                  List<Widget> innerList = new List<Widget>();
                  innerList.add(JournalIllustration(journal));
                  list.add(Column(
                    children: innerList,
                  ));
                });
              } else {
                list.add(Text("No journals"));
              }
              return ListView(
                padding: EdgeInsets.symmetric(horizontal: offset),
                scrollDirection: Axis.horizontal,
                children: list,
              );
            }));
  }
}
