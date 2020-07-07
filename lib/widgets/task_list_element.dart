import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mylk/bloc/task_bloc.dart';
import 'package:mylk/model/task_model.dart';
import 'package:mylk/notifications/notification_helper.dart';
import 'package:mylk/screens/task_form_screen.dart';

class TaskListElement extends StatelessWidget {
  final TaskBloc _taskBloc;
  final Task task;
  final Key key;

  const TaskListElement(this.key, this._taskBloc, this.task);

  toggleCompleted() {
    task.isDone = !task.isDone;
    if (task.isDone && task.hasNotification) {
      turnOffNotificationById(task.id);
    }
    task.doneAt = task.isDone ? DateTime.now() : null;
    _taskBloc.updateTask(task);
  }

  @override
  Widget build(BuildContext context) {
    bool isLate = task.due != null && task.due.isBefore(DateTime.now()) && !task.isDone;
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
          toggleCompleted();
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
        if (task.hasNotification) {
          turnOffNotificationById(task.id);
        }
        _taskBloc.deleteTaskById(task.id);
      },
      child: ListTile(
        title: AnimatedOpacity(
          duration: Duration(milliseconds: 250),
          opacity: task.isDone ? 0.5 : 1,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            decoration: BoxDecoration(
                boxShadow: [
                  new BoxShadow(
                      offset: Offset(0.0, 4.0),
                      color: Colors.black38,
                      blurRadius: 5.0)
                ],
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(10.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(task.title,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                if (task.due != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        if (isLate) Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: FaIcon(FontAwesomeIcons.exclamationTriangle, color: Colors.white, size: 12.0),
                        ),
                        if (task.hasNotification) Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: FaIcon(FontAwesomeIcons.bell, color: Colors.white, size: 12.0),
                        ),
                        Expanded(
                            flex: 1,
                            child: Text(
                                DateFormat('yyyy-MM-dd - kk:mm').format(task.due),
                                style: TextStyle(color: Colors.white))),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: FaIcon(task.isDone == true
                  ? FontAwesomeIcons.checkSquare
                  : FontAwesomeIcons.square),
            ),
          ],
        ),
        onTap: () {
          toggleCompleted();
        },
        onLongPress: () {
          showModalBottomSheet(
            backgroundColor: Colors.transparent,
            context: context,
            builder: (context) => TaskFormScreen(task)
          );
        },
      ),
    );
  }
}
