import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class JournalEntryScreen extends StatelessWidget {
  final journalEntry;

  const JournalEntryScreen(this.journalEntry);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0))),
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Stack(
          children: <Widget>[
            Positioned(
              bottom: 0,
              right: 0,
              child: FaIcon(
                journalEntry.mood.icon,
                color: Colors.white.withOpacity(0.08),
                size: 200.0,
              ),
            ),
            ListView(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(journalEntry.title != null ? journalEntry.title : "",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20.0)),
                    Text(
                      DateFormat('yyyy/MM/dd - kk:mm')
                          .format(journalEntry.date),
                      textAlign: TextAlign.right,
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    journalEntry.content != null ? journalEntry.content : "",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
