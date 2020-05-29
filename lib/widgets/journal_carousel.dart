import 'package:flutter/material.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';
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
    return Column(
      children: <Widget>[
        Container(
          height: 300.0,
          child: ListView.builder(
              controller: _journalScrollController,
              padding: EdgeInsets.symmetric(horizontal: offset),
              scrollDirection: Axis.horizontal,
              itemCount: journals.length,
              itemBuilder: (BuildContext context, int index) {
                Journal journal = journals[index];
                return GestureDetector (
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => JournalScreen(
                        journal
                      )
                    )
                  ),
                  child: Container(
                      width: MediaQuery.of(context).size.width - offset * 2,
                      child: Stack(
                        children: <Widget>[
                          Hero(
                            tag: journal.backGroundImage,
                            child: Container(
                              margin: EdgeInsets.all(40.0),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    new BoxShadow(
                                        color: Colors.black45, blurRadius: 15.0)
                                  ],
                                  image: DecorationImage(
                                      image: AssetImage("assets/images/${journal.backGroundImage}.jpg"),
                                      fit: BoxFit.cover),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(2.0),
                                      bottomLeft: Radius.circular(2.0),
                                      topRight: Radius.circular(20.0),
                                      bottomRight: Radius.circular(20.0))),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Container(
                                    width: 10.0,
                                    margin: EdgeInsets.only(right: 30.0),
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        boxShadow: [
                                          new BoxShadow(
                                              color: Colors.black26, blurRadius: 1.5)
                                        ]),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child:
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Text(journal.title, style: TextStyle(color: Colors.black, fontSize: 15.0)),
                                  Text('${journal.journalEntries != null ? journal.journalEntries.length : 0} entries', style: TextStyle(color: Colors.black, fontSize: 10.0)),
                                ],
                              )
                          )
                        ],
                      )),
                );
              }),
        ),
      ],
    );
  }
}
