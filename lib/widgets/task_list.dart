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
  TaskBloc taskBloc;

  @override
  Widget build(BuildContext context) {
    taskBloc = BlocProvider.of(context).taskBloc;
    if (widget.date != null) {
      String year = widget.date.year.toString();
      String month = widget.date.month < 10 ? "0" + widget.date.month.toString() : widget.date.month.toString();
      String day = widget.date.day < 10 ? "0" + widget.date.day.toString() : widget.date.day.toString();
      String dateString = [year, month, day].join("-");
      taskBloc.getTasks(query: {
        "where": "due like ?",
        "args": ["%$dateString%"]
      });
    } else {
      taskBloc.getTasks(query: null);
    }
    return StreamBuilder(
        stream: taskBloc.tasks,
        builder: (BuildContext context, AsyncSnapshot<List<Task>> snapshot) {
          List<Widget> list = new List<Widget>();
          if (snapshot != null &&
              snapshot.data != null &&
              snapshot.data.length != 0) {
            snapshot.data.forEach((task) {
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
                    taskBloc.updateTask(task);
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
                  taskBloc.deleteTaskById(task.id);
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
                    taskBloc.updateTask(task);
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
