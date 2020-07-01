import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mylk/model/journal_model.dart';
import 'package:mylk/screens/journal_entry_form_screen.dart';
import 'package:mylk/widgets/journal_entry_list.dart';

import 'journal_form_screen.dart';

class JournalScreen extends StatelessWidget {
  final Journal journal;

  JournalScreen(this.journal);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0)
            ),
            child: CloseButton(
              color: Colors.black54,
            ),
          ),
        ),
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      journal.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20.0, color: Colors.black54, fontFamily: 'Pacifico'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 40.0,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0)
              ),
              child: IconButton(
                icon: FaIcon(FontAwesomeIcons.pencilAlt),
                color: Colors.black54,
                iconSize: 20.0,
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => JournalFormSceen(journal)));
                },
              )
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => JournalEntryFormScreen(null, journal, null)));
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: FaIcon(FontAwesomeIcons.fileAlt),
      ),
      body: Hero(
          tag: journal.id,
          child: Material(
            type: MaterialType.transparency,
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                      image: AssetImage(journal.backgroundImagePath),
                      fit: BoxFit.cover),
                ),
                child: SafeArea(
                  child: Container(
                      margin: EdgeInsets.all(10.0),
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: JournalEntryList(journal, null)),
                )),
          )),
    );
  }
}
