import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mylk/bloc/task_bloc.dart';
import 'package:mylk/model/task_model.dart';
import 'package:mylk/screens/task_form_screen.dart';

class TaskListElement extends StatelessWidget {
  final TaskBloc _taskBloc;
  final Task task;
  final Key key;

  const TaskListElement(this.key, this._taskBloc, this.task);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(task.id),
      background: Container(
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
                    color: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      secondaryBackground: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ListTile(
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FaIcon(
                    FontAwesomeIcons.trashAlt,
                    color: Theme.of(context).primaryColor,
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
          task.doneAt = task.isDone ? DateTime.now() : null;
          _taskBloc.updateTask(task);
          return false;
        } else {
          return await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Confirm"),
                content:
                    const Text("Are you sure you wish to delete this item?"),
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
        _taskBloc.deleteTaskById(task.id);
      },
      child: ListTile(
        title: Text(task.title),
        subtitle: task.due != null
            ? Text(DateFormat('yyyy-MM-dd - kk:mm').format(task.due))
            : null,
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
          task.doneAt = task.isDone ? DateTime.now() : null;
          _taskBloc.updateTask(task);
        },
        onLongPress: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => TaskFormScreen(task)));
        },
      ),
    );
  }
}
