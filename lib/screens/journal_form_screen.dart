import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mylk/bloc/bloc_provider.dart';
import 'package:mylk/bloc/journal_bloc.dart';
import 'package:mylk/model/journal_model.dart';
import 'package:mylk/widgets/imagePicker.dart';

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
    _backgroundImage =
        widget.journal != null ? widget.journal.backgroundImage : "bg-1";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _journalBloc = BlocProvider.of(context).journalBloc;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text('Add journal', style: TextStyle(fontFamily: 'Pacifico')),
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
                  child: ImagePicker(
                    callback: (name) {
                      setState(() {
                        _backgroundImage = name;
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
                                    backgroundImage: _backgroundImage));
                              });
                            } else {
                              widget.journal.title = _title;
                              widget.journal.backgroundImage = _backgroundImage;
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
                            setState(() {
                              _journalBloc.deleteJournalById(widget.journal.id);
                            });
                          }
                          Navigator.pop(context);
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
