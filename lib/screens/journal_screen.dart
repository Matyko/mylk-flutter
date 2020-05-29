import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mylk/model/journal_model.dart';

class JournalScreen extends StatefulWidget {
  final Journal journal;

  JournalScreen(this.journal);

  @override
  _JournalScreenState createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Hero(
                  tag: widget.journal.backGroundImage,
                  child: Material(
                    type: MaterialType.transparency,
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          image: DecorationImage(
                              image: AssetImage(
                                  "assets/images/${widget.journal.backGroundImage}.jpg"),
                              fit: BoxFit.cover),
                        ),
                        child: SafeArea(
                          child: Container(
                            margin: EdgeInsets.all(10.0),
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      width: 100.0,
                                      child: Row(
                                          children: <Widget>[
                                            CloseButton()
                                          ],
                                      ),
                                    ),
                                    Expanded(
                                        flex: 2,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              widget.journal.title,
                                              style: TextStyle(
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        )),
                                    SizedBox(width: 100.0,)
                                  ],
                                ),
                                
                              ],
                            ),
                          ),
                        )),
                  )),
            ],
          )
        ],
      ),
    );
  }
}
