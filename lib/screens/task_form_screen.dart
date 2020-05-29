import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mylk/bloc/task_bloc.dart';
import 'package:mylk/model/task_model.dart';
import 'package:mylk/widgets/date_time_picker.dart';

class TaskFormScreen extends StatefulWidget {
  final Task task;
  final TaskBloc taskBloc;

  TaskFormScreen(this.task, this.taskBloc);

  @override
  _TaskFormScreenState createState() => _TaskFormScreenState();
}

class _TaskFormScreenState extends State<TaskFormScreen> {
  final _formKey = GlobalKey<FormState>();
  DateTime _dateTime;
  String _title;

  @override
  void initState() {
    super.initState();
    _dateTime = widget.task != null ? widget.task.due : DateTime.now();
    _title = widget.task != null ? widget.task.title : "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text('Add task'),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
        child: Form(
          key: _formKey,
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TextFormField(
                          initialValue: _title,
                          decoration: InputDecoration(
                              icon: FaIcon(FontAwesomeIcons.pencilAlt),
                              labelText: 'Task description'),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          onSaved: (String value) {
                            _title = value;
                          },
                        ),
                        DateTimePickerField(_dateTime, (dateTime) {
                          setState(() {
                            _dateTime = dateTime;
                          });
                        })
                      ],
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      SizedBox(
                        width: double.infinity,
                        child: FlatButton(
                            color: Theme.of(context).primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                                if (widget.task == null) {
                                  widget.taskBloc.addTask(Task(title: _title, due: _dateTime));
                                } else {
                                  widget.task.title = _title;
                                  widget.task.due = _dateTime;
                                  widget.taskBloc.updateTask(widget.task);
                                }
                                Navigator.pop(context);
                              }
                            },
                            child: Text(
                              widget.task != null ? 'Update' : 'Submit',
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: FlatButton(
                            color: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            onPressed: () {
                                if (widget.task == null) {
                                  Navigator.pop(context);
                                } else {
                                  widget.taskBloc.deleteTaskById(widget.task.id);
                                }
                                Navigator.pop(context);
                            },
                            child: Text(
                              widget.task != null ? 'Delete' : 'Cancel',
                              style: TextStyle(color: Colors.red),
                            )),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
