import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mylk/bloc/bloc_provider.dart';
import 'package:mylk/bloc/journal_entry_bloc.dart';
import 'package:mylk/model/journal_entry_model.dart';
import 'package:mylk/model/journal_model.dart';

class JournalEntryFormScreen extends StatefulWidget {
  final JournalEntry journalEntry;
  final Journal journal;
  final Function onChange;

  const JournalEntryFormScreen(this.journalEntry, this.journal, this.onChange);

  @override
  _JournalEntryFormScreenState createState() => _JournalEntryFormScreenState();
}

class _JournalEntryFormScreenState extends State<JournalEntryFormScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title;
  String _content;
  int _journalId;
  List<String> _images;
  JournalEntryBloc _journalEntryBloc;

  @override
  void initState() {
    _title = widget.journalEntry != null ? widget.journalEntry.title : "";
    _content = widget.journalEntry != null ? widget.journalEntry.content : "";
    _journalId = widget.journalEntry != null ? widget.journalEntry.journalId : widget.journal.id;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _journalEntryBloc = BlocProvider.of(context).journalEntryBloc;
    return Scaffold(
      appBar: AppBar(
        title: Text('Add entry to journal: ${widget.journal.title}'),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: TextFormField(
                  initialValue: _title,
                  decoration: InputDecoration(
                      icon: FaIcon(FontAwesomeIcons.pencilAlt),
                      labelText: 'Title'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  onSaved: (String value) {
                    setState(() {
                      _title = value;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: TextFormField(
                  initialValue: _content,
                  decoration: InputDecoration(
                      icon: FaIcon(FontAwesomeIcons.pencilAlt),
                      labelText: 'Content'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  onSaved: (String value) {
                    setState(() {
                      _content = value;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: SizedBox(
                  width: double.infinity,
                  child: FlatButton(
                      color: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          if (widget.journalEntry == null) {
                            setState(() {
                              _journalEntryBloc.addJournalEntry(JournalEntry(
                                  journalId: _journalId,
                                  title: _title,
                                  content: _content));
                            });
                          } else {
                            widget.journalEntry.title = _title;
                            widget.journalEntry.content = _content;
                            setState(() {
                              _journalEntryBloc.updateJournalEntry(widget.journalEntry);
                            });
                          }
                          Navigator.pop(context);
                          if (widget.onChange != null) {
                            widget.onChange();
                          }
                        }
                      },
                      child: Text(
                        widget.journalEntry != null ? 'Update' : 'Submit',
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              )
            ],
          )
        ),
      ),
    );
  }
}
