import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mylk/bloc/bloc_provider.dart';
import 'package:mylk/bloc/task_bloc.dart';
import 'package:mylk/model/task_model.dart';
import 'package:mylk/notifications/notification_helper.dart';
import 'package:mylk/widgets/date_time_picker.dart';

class TaskFormScreen extends StatefulWidget {
  final Task task;

  TaskFormScreen(this.task);

  @override
  _TaskFormScreenState createState() => _TaskFormScreenState();
}

class _TaskFormScreenState extends State<TaskFormScreen> {
  final _formKey = GlobalKey<FormState>();
  DateTime _dateTime;
  String _title;
  bool _notify;
  TaskBloc taskBloc;

  @override
  void initState() {
    _dateTime = widget.task != null ? widget.task.due : DateTime.now();
    _title = widget.task != null ? widget.task.title : "";
    _notify = widget.task != null ? widget.task.hasNotification : false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    taskBloc = BlocProvider.of(context).taskBloc;
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0))
      ),
      child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text( widget.task != null ? "Edit task" : "Add task", style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold)),
              ),
              Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 20.0),
                    width: 40.0,
                    child: Checkbox(
                      value: _dateTime != null,
                      activeColor: Theme.of(context).primaryColor,
                      onChanged: (newValue) {
                        setState(() {
                          _dateTime = newValue ? DateTime.now() : null;
                          _notify = false;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        child: _dateTime == null
                            ? Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15.0),
                                child: Text("No date",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              )
                            : DateTimePickerField(_dateTime, (dateTime) {
                                setState(() {
                                  _dateTime = dateTime;
                                });
                              }, true),
                      ),
                    ),
                  ),
                  if (_dateTime != null)
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            _notify = !_notify;
                          });
                        },
                        icon: FaIcon(
                          _notify
                              ? FontAwesomeIcons.bell
                              : FontAwesomeIcons.bellSlash,
                          color: Colors.white,
                        ),
                      ),
                    )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                    right: 20.0, top: 10.0, left: 60.0),
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
                      labelText: 'Task description'),
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
              SizedBox(height: 150.0,),
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
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          bool addNotification =
                              _notify && _dateTime.isAfter(DateTime.now());
                          if (widget.task == null) {
                            int id = await taskBloc.addTask(Task(
                                title: _title,
                                due: _dateTime,
                                priority: 0,
                                hasNotification: addNotification));
                            if (id != null && addNotification) {
                              scheduleNotification(id, _title, _dateTime);
                            }
                          } else {
                            if (widget.task.hasNotification) {
                              turnOffNotificationById(widget.task.id);
                            }
                            if (addNotification) {
                              scheduleNotification(
                                  widget.task.id, _title, _dateTime);
                              widget.task.hasNotification = true;
                            }
                            widget.task.hasNotification = addNotification;
                            widget.task.title = _title;
                            widget.task.due = _dateTime;
                            await taskBloc.updateTask(widget.task);
                          }
                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        widget.task != null ? 'Update' : 'Add task',
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              ),
            ],
          ),
        ),
    );
  }
}
