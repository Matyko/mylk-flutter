import 'package:flutter/material.dart';
import 'package:mylk/bloc/bloc_provider.dart';
import 'package:mylk/bloc/journal_bloc.dart';
import 'package:mylk/bloc/journal_entry_bloc.dart';
import 'package:mylk/model/journal_model.dart';
import 'package:mylk/state/global_state.dart';
import 'package:provider/provider.dart';

import 'journal_entry_list.dart';
import 'journal_illustration.dart';

class JournalCarousel extends StatefulWidget {
  final bool showSummary;

  const JournalCarousel({this.showSummary = false});

  @override
  _JournalCarouselState createState() => _JournalCarouselState();
}

class _JournalCarouselState extends State<JournalCarousel> {
  JournalBloc _journalBloc;
  JournalEntryBloc _journalEntryBloc;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final globalState = Provider.of<GlobalState>(context);
    final double offset = MediaQuery.of(context).size.width * 0.2;
    _journalBloc = BlocProvider.of(context).journalBloc;
    _journalEntryBloc = BlocProvider.of(context).journalEntryBloc;
    _journalBloc.getJournals();
    _journalEntryBloc.getJournalEntries();
    return Container(
        height: widget.showSummary ? 600.0 : 300.0,
        child: StreamBuilder(
            stream: _journalBloc.journals,
            builder:
                (BuildContext context, AsyncSnapshot<List<Journal>> snapshot) {
              List<Widget> list = new List<Widget>();
              if (snapshot != null &&
                  snapshot.data != null &&
                  snapshot.data.length != 0) {
                _pageController.addListener(() {
                  if (_pageController.page == _pageController.page.floor()) {
                    setState(() {
                      globalState.updateCurrentJournal(snapshot.data[_pageController.page.floor()]);
                    });
                  }
                });
                globalState.currentJournal = snapshot.data[0];
                snapshot.data.forEach((journal) {
                  List<Widget> innerList = new List<Widget>();
                  innerList.add(Padding(
                      padding: EdgeInsets.symmetric(horizontal: offset),
                      child: JournalIllustration(journal)));
                  if (widget.showSummary) {
                    innerList.add(Container(
                      height: 300.0,
                      width: MediaQuery.of(context).size.width,
                      child: JournalEntryList(journal, 3),
                    ));
                  }
                  list.add(Column(
                    children: innerList,
                  ));
                });
              } else {
                list.add(Text("No journals"));
              }
              return PageView(
                controller: _pageController,
                scrollDirection: Axis.horizontal,
                children: list,
              );
            }));
  }
}
