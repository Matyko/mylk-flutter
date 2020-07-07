import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0))
      ),
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: ListView(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(journalEntry.title != null ? journalEntry.title : "", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                  Text(
                    DateFormat('yyyy/MM/dd - kk:mm').format(journalEntry.date),
                    textAlign: TextAlign.right,
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(
                    journalEntry.content != null ? journalEntry.content : "", style: TextStyle(color: Colors.white),),
              ),
            ],
          ),
      ),
    );
  }
}
