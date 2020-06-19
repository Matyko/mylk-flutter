import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mylk/bloc/bloc_provider.dart';
import 'package:mylk/bloc/journal_entry_bloc.dart';
import 'package:mylk/model/journal_entry_model.dart';
import 'package:mylk/model/journal_model.dart';
import 'package:mylk/model/mood_model.dart';
import 'package:mylk/state/global_state.dart';
import 'package:mylk/widgets/date_time_picker.dart';
import 'package:provider/provider.dart';

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
  Mood _mood;
  int _journalId;
  DateTime _dateTime;
  List<String> _images;
  JournalEntryBloc _journalEntryBloc;
  PageController _pageController;
  JournalEntryState _state;

  @override
  void initState() {
    _title = widget.journalEntry != null ? widget.journalEntry.title : "";
    _content = widget.journalEntry != null ? widget.journalEntry.content : "";
    _journalId = widget.journalEntry != null
        ? widget.journalEntry.journalId
        : widget.journal.id;
    _dateTime = widget.journalEntry != null ? widget.journalEntry.date : DateTime.now();
    _pageController = new PageController(initialPage: 0, keepPage: true);
    _state = Provider.of<JournalEntryState>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _journalEntryBloc = BlocProvider.of(context).journalEntryBloc;
    List<Widget> moodButtons = List<Widget>();
    baseMoods.forEach((mood) {
      moodButtons.add(
        FlatButton(
          onPressed: () {
            setState(() {
              _mood = mood;
            });
            _pageController.animateToPage(1,
                duration: Duration(milliseconds: 1000),
                curve: Curves.easeOutQuint);
          },
          child: Container(
              decoration: BoxDecoration(
                  color: Colors.white54,
                  borderRadius: BorderRadius.circular(10.0)),
              padding: EdgeInsets.all(10.0),
              child: FaIcon(
                mood.icon,
                color: Theme.of(context).primaryColor,
              )),
        ),
      );
    });
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text('New entry to ${widget.journal.title}'),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.transparent
      ),
      body: PageView(
        physics: new NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: <Widget>[
          Container(
            child: Column(children: <Widget>[
              Expanded(
                flex: 0,
                child: Padding(
                  padding: EdgeInsets.only(right: 10.0, left: 10.0, top: 50.0),
                  child: Text(
                    "How is your mood?",
                    style: TextStyle(fontSize: 30.0, color: Colors.white70),
                  ),
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: moodButtons,
                  )),
              SizedBox(
                height: 150,
              )
            ]),
          ),
          SingleChildScrollView(
            child: Container(
              padding: MediaQuery.of(context).viewInsets,
              height: MediaQuery.of(context).size.height - 80.0,
              width: MediaQuery.of(context).size.width,
              child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(
                              flex:0,
                              child: FlatButton(
                                onPressed: () {
                                  _pageController.animateToPage(0,
                                      duration: Duration(milliseconds: 1000),
                                      curve: Curves.easeOutQuint);
                                },
                                child: _mood != null
                                    ? Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white54,
                                            borderRadius: BorderRadius.circular(10.0)),
                                        padding: EdgeInsets.all(10.0),
                                        child: FaIcon(
                                          _mood.icon,
                                          color: Theme.of(context).primaryColor,
                                        ))
                                    : null,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(right: 20.0),
                              width: 200.0,
                              child: DateTimePickerField(_dateTime, (dateTime) {
                                setState(() {
                                  _dateTime = dateTime;
                                });
                              }, false),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        child: TextFormField(
                          initialValue: _title,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white60,
                              labelStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor),
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white54),
                                  borderRadius: BorderRadius.circular(10.0)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white54),
                                  borderRadius: BorderRadius.circular(10.0)),
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
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                          child: TextFormField(
                            maxLines: 99,
                            initialValue: _content,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white60,
                                labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.auto,
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white54),
                                    borderRadius: BorderRadius.circular(10.0)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white54),
                                    borderRadius: BorderRadius.circular(10.0)),
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
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
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
                                      _journalEntryBloc.addJournalEntry(
                                          JournalEntry(
                                              journalId: _journalId,
                                              title: _title,
                                              mood: _mood,
                                              date: _dateTime,
                                              content: _content));
                                    });
                                  } else {
                                    widget.journalEntry.title = _title;
                                    widget.journalEntry.content = _content;
                                    widget.journalEntry.mood = _mood;
                                    widget.journalEntry.date = _dateTime;
                                    setState(() {
                                      _journalEntryBloc.updateJournalEntry(
                                          widget.journalEntry);
                                    });
                                  }
                                  Navigator.pop(context);
                                  if (widget.onChange != null) {
                                    widget.onChange();
                                  }
                                }
                                if (_journalId != null) {
                                  _state.refreshJournalEntries(_journalId);
                                }
                              },
                              child: Text(
                                widget.journalEntry != null
                                    ? 'Update entry'
                                    : 'Create entry',
                                style: TextStyle(color: Colors.white),
                              )),
                        ),
                      )
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
