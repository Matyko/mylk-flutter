import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mylk/bloc/bloc_provider.dart';
import 'package:mylk/bloc/task_bloc.dart';
import 'package:mylk/model/task_model.dart';
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
  TaskBloc taskBloc;

  @override
  void initState() {
    _dateTime = widget.task != null ? widget.task.due : DateTime.now();
    _title = widget.task != null ? widget.task.title : "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    taskBloc = BlocProvider.of(context).taskBloc;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text('Add task'),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 20.0, vertical: 10.0),
            child: Card(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
                    child: TextFormField(
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
                        setState(() {
                          _title = value;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
                    child: DateTimePickerField(_dateTime, (dateTime) {
                      setState(() {
                        _dateTime = dateTime;
                      });
                    }),
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
                              if (widget.task == null) {
                                setState(() {
                                  taskBloc
                                      .addTask(Task(title: _title, due: _dateTime));
                                });
                              } else {
                                widget.task.title = _title;
                                widget.task.due = _dateTime;
                                setState(() {
                                  taskBloc.updateTask(widget.task);
                                });
                              }
                              Navigator.pop(context);
                            }
                          },
                          child: Text(
                            widget.task != null ? 'Update' : 'Submit',
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
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
