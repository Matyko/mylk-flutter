import 'package:flutter/material.dart';
import 'package:mylk/bloc/bloc_provider.dart';
import 'package:mylk/bloc/journal_bloc.dart';
import 'package:mylk/model/journal_model.dart';
import 'package:mylk/state/global_state.dart';
import 'package:mylk/widgets/mylk_image_picker.dart';
import 'package:provider/provider.dart';

class JournalFormSceen extends StatefulWidget {
  final Journal journal;

  JournalFormSceen(this.journal);

  @override
  _JournalFormSceenState createState() => _JournalFormSceenState();
}

class _JournalFormSceenState extends State<JournalFormSceen> {
  final _formKey = GlobalKey<FormState>();
  String _title;
  String _backgroundImage;
  JournalBloc _journalBloc;

  @override
  void initState() {
    _title = widget.journal != null ? widget.journal.title : "";
    _backgroundImage =  widget.journal != null ? widget.journal.backgroundImagePath : "assets/images/bg-1.jpg";
    super.initState();
  }

  confirmDelete() async {
    bool shouldDelete = await showDialog(
        context: context,
        builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Confirm"),
        content: const Text(
            "Are you sure you wish to delete this journal? You will loose all entries."),
        actions: <Widget>[
          FlatButton(
              onPressed: () =>
                  Navigator.of(context).pop(true),
              child: const Text("DELETE")),
          FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text("CANCEL"),
          ),
        ],
      );
    });
    if (shouldDelete) {
      JournalState journalState = Provider.of<JournalState>(context);
      if (journalState.currentJournal == widget.journal) {
        journalState.currentJournal = null;
      }
      _journalBloc.deleteJournalById(widget.journal.id);
      Navigator.of(context).pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    _journalBloc = BlocProvider.of(context).journalBloc;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text(widget.journal != null ? 'Edit ${widget.journal.title}' : 'Create journal'),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: MediaQuery.of(context).viewInsets,
          height: MediaQuery.of(context).size.height - 80.0,
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: MylkImagePicker(
                    selected: widget.journal != null ? widget.journal.backgroundImagePath : null,
                    callback: (path) {
                      setState(() {
                        _backgroundImage = path;
                      });
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    child: TextFormField(
                      initialValue: _title,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white60,
                          labelStyle: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white54),
                              borderRadius: BorderRadius.circular(10.0)
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white54),
                              borderRadius: BorderRadius.circular(10.0)
                          ),
                          labelText: 'Journal name'),
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
                            if (widget.journal == null) {
                              setState(() {
                                _journalBloc.addJournal(Journal(
                                    title: _title,
                                    backgroundImagePath: _backgroundImage));
                              });
                            } else {
                              widget.journal.title = _title;
                              widget.journal.backgroundImagePath = _backgroundImage;
                              setState(() {
                                _journalBloc.updateJournal(widget.journal);
                              });
                            }
                            Navigator.pop(context);
                          }
                        },
                        child: Text(
                          widget.journal != null ? 'Update journal' : 'Create journal',
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: FlatButton(
                        color: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        onPressed: () {
                          if (widget.journal == null) {
                            Navigator.pop(context);
                          } else {
                            confirmDelete();
                          }
                        },
                        child: Text(
                          widget.journal != null ? 'Delete journal' : 'Cancel',
                          style: TextStyle(color: Colors.red),
                        )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
