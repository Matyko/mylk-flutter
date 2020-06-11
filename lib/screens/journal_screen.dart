import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mylk/model/journal_model.dart';
import 'package:mylk/screens/journal_entry_form_screen.dart';
import 'package:mylk/widgets/journal_entry_list.dart';

import 'journal_form_screen.dart';

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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.white38,
        elevation: 0.0,
        leading: CloseButton(
          color: Colors.black,
        ),
        centerTitle: true,
        title: Text(
          widget.journal.title,
          style: TextStyle(fontSize: 20.0, color: Colors.black),
        ),
        actions: <Widget>[
          IconButton(
            icon: FaIcon(FontAwesomeIcons.cog),
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => JournalFormSceen(widget.journal)));
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => JournalEntryFormScreen(null, widget.journal, null)));
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: FaIcon(FontAwesomeIcons.fileAlt),
      ),
      body: Hero(
          tag: widget.journal.id,
          child: Material(
            type: MaterialType.transparency,
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                      image: AssetImage(
                          "assets/images/${widget.journal.backgroundImage}.jpg"),
                      fit: BoxFit.cover),
                ),
                child: SafeArea(
                  child: Container(
                      margin: EdgeInsets.all(10.0),
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: JournalEntryList(widget.journal, null)),
                )),
          )),
    );
  }
}
