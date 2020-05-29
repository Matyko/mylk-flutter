import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mylk/bloc/task_bloc.dart';
import 'package:mylk/model/task_model.dart';
import 'package:mylk/screens/task_form_screen.dart';

Widget getTaskList(TaskBloc taskBloc, DateTime date) {
  if (date != null) {
    String dateString = date.toIso8601String().split(":")[0];
    taskBloc.getTasks(query: {
      "where": "due like ?",
      "args": ["%$dateString%"]
    });
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
              background: ListTile(
                leading: FaIcon(task.isDone == true
                    ? FontAwesomeIcons.square
                    : FontAwesomeIcons.checkSquare),
              ),
              secondaryBackground: ListTile(
                trailing: FaIcon(FontAwesomeIcons.trashAlt),
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
                              onPressed: () => Navigator.of(context).pop(true),
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
                leading: FaIcon(task.isDone == true
                    ? FontAwesomeIcons.checkSquare
                    : FontAwesomeIcons.square),
                onTap: () {
                  task.isDone = !task.isDone;
                  taskBloc.updateTask(task);
                },
                onLongPress: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => TaskFormScreen(task, taskBloc)));
                },
              ),
            ));
          });
        } else {
          list.add(ListTile(
              leading: FaIcon(FontAwesomeIcons.check),
              title: Text("No tasks for today")));
        }
        return ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: list,
        );
      });
}
