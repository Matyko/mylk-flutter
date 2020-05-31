import 'package:flutter/material.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';
import 'package:mylk/bloc/bloc_provider.dart';
import 'package:mylk/bloc/journal_bloc.dart';
import 'package:mylk/bloc/journal_entry_bloc.dart';
import 'package:mylk/model/journal_model.dart';
import 'package:mylk/screens/journal_screen.dart';

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
    return Column(
      children: <Widget>[
        Container(
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
                      list.add(GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => JournalScreen(journal))),
                        child: Container(
                            width:
                                MediaQuery.of(context).size.width - offset * 2,
                            height: 300.0,
                            child: Stack(
                              children: <Widget>[
                                Hero(
                                  tag: journal.id,
                                  child: Container(
                                    margin: EdgeInsets.all(40.0),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          new BoxShadow(
                                              color: Colors.black45,
                                              blurRadius: 15.0)
                                        ],
                                        image: DecorationImage(
                                            image: AssetImage(
                                                "assets/images/${journal.backgroundImage}.jpg"),
                                            fit: BoxFit.cover),
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(2.0),
                                            bottomLeft: Radius.circular(2.0),
                                            topRight: Radius.circular(20.0),
                                            bottomRight:
                                                Radius.circular(20.0))),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Container(
                                          width: 10.0,
                                          margin: EdgeInsets.only(right: 30.0),
                                          decoration: BoxDecoration(
                                              color: Colors.black,
                                              boxShadow: [
                                                new BoxShadow(
                                                    color: Colors.black26,
                                                    blurRadius: 1.5)
                                              ]),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Text(journal.title,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15.0))
                                      ],
                                    ))
                              ],
                            )),
                      ));
                    });
                  } else {
                    list.add(Text("No journals"));
                  }
                  return ListView(
                    controller: _journalScrollController,
                    padding: EdgeInsets.symmetric(horizontal: offset),
                    scrollDirection: Axis.horizontal,
                    children: list,
                  );
                })),
      ],
    );
  }
}
