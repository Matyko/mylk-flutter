import 'package:flutter/material.dart';
import 'package:mylk/model/journal_model.dart';
import 'package:mylk/screens/journal_screen.dart';

class JournalIllustration extends StatelessWidget {
  final Journal journal;

  const JournalIllustration(this.journal);

  @override
  Widget build(BuildContext context) {
    final double offset = MediaQuery.of(context).size.width * 0.2;
    return GestureDetector(
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
              Align(
                child: Hero(
                  tag: journal.id,
                  child: Container(
                    width: 150.0,
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
                                journal.backgroundImagePath),
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
    );
  }
}
