import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mylk/bloc/bloc_provider.dart';
import 'package:mylk/bloc/task_bloc.dart';
import 'package:mylk/model/task_model.dart';
import 'package:mylk/screens/task_form_screen.dart';

class TaskList extends StatefulWidget {
  final DateTime date;

  const TaskList({Key key, this.date}) : super(key: key);

  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  TaskBloc _taskBloc;
  DateTime _currentDate;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final taskBloc = BlocProvider.of(context).taskBloc;
    if (_taskBloc != taskBloc) {
      _taskBloc = taskBloc;
      if (widget.date != null) {
        final int startOfDay = DateTime(widget.date.year, widget.date.month, widget.date.day).millisecondsSinceEpoch;
        final int endOfDay = DateTime(widget.date.year, widget.date.month, widget.date.day, 23, 59, ).millisecondsSinceEpoch;
        taskBloc.getTasks(query: {
          "where": "due > ? AND due < ?",
          "args": [startOfDay, endOfDay]
        });
      } else {
        taskBloc.getTasks(query: null);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _taskBloc = BlocProvider.of(context).taskBloc;
    return StreamBuilder(
        stream: _taskBloc.tasks,
        builder: (BuildContext context, AsyncSnapshot<List<Task>> snapshot) {
          List<Widget> list = new List<Widget>();
          _currentDate = null;
          if (snapshot != null &&
              snapshot.data != null &&
              snapshot.data.length != 0) {
            snapshot.data.forEach((task) {
              if ((_currentDate == null
                  || _currentDate.year != task.due.year
                  || _currentDate.month != task.due.month
                  || _currentDate.day != task.due.day
              ) && widget.date == null) {
                _currentDate = task.createdAt;
                list.add(ListTile(
                    title: Text(DateFormat('yyyy.MM.dd').format(task.due))
                ));
              }
              list.add(Dismissible(
                background: Container(
                  color: Theme.of(context).primaryColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ListTile(
                        leading: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            FaIcon(
                              task.isDone == true
                                  ? FontAwesomeIcons.square
                                  : FontAwesomeIcons.checkSquare,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                secondaryBackground: Container(
                  color: Colors.red,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ListTile(
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            FaIcon(
                              FontAwesomeIcons.trashAlt,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                confirmDismiss: (DismissDirection direction) async {
                  if (direction == DismissDirection.startToEnd) {
                    task.isDone = !task.isDone;
                    _taskBloc.updateTask(task);
                    return false;
                  } else {
                    return await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Confirm"),
                          content: const Text(
                              "Are you sure you wish to delete this item?"),
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
                      },
                    );
                  }
                },
                onDismissed: (DismissDirection direction) {
                  _taskBloc.deleteTaskById(task.id);
                },
                key: Key(task.title),
                child: ListTile(
                  title: Text(task.title),
                  subtitle:
                      Text(DateFormat('yyyy-MM-dd - kk:mm').format(task.due)),
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FaIcon(task.isDone == true
                          ? FontAwesomeIcons.checkSquare
                          : FontAwesomeIcons.square),
                    ],
                  ),
                  onTap: () {
                    task.isDone = !task.isDone;
                    _taskBloc.updateTask(task);
                  },
                  onLongPress: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => TaskFormScreen(task)));
                  },
                ),
              ));
            });
          } else {
            list.add(ListTile(
                leading: FaIcon(FontAwesomeIcons.check),
                title: Text(
                    widget.date != null ? "No tasks for today" : "No tasks")));
          }
          return ListView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: list,
          );
        });
  }
}
