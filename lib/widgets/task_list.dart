import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mylk/bloc/bloc_provider.dart';
import 'package:mylk/bloc/task_bloc.dart';
import 'package:mylk/model/task_model.dart';
import 'package:mylk/widgets/task_list_element.dart';

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
        final int startOfDay =
            DateTime(widget.date.year, widget.date.month, widget.date.day)
                .millisecondsSinceEpoch;
        final int endOfDay = DateTime(
          widget.date.year,
          widget.date.month,
          widget.date.day,
          23,
          59,
        ).millisecondsSinceEpoch;
        taskBloc.getTasks(query: {
          "where":
              "due > ? AND due < ? OR is_done = 0 AND due IS NULL",
          "args": [startOfDay, endOfDay],
          "orderBy": "+due"
        });
      } else {
        taskBloc.getTasks(query: {"orderBy": "+due"});
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
          List<Widget> prioList = List<Widget>();
          _currentDate = null;
          if (snapshot != null &&
              snapshot.data != null &&
              snapshot.data.length != 0) {
            snapshot.data
                .where((task) => task.due != null)
                .toList()
                .forEach((task) {
              if ((_currentDate == null ||
                      _currentDate.year != task.due.year ||
                      _currentDate.month != task.due.month ||
                      _currentDate.day != task.due.day) &&
                  widget.date == null) {
                _currentDate = task.createdAt;
                list.add(ListTile(
                    title: Container(
                        padding: EdgeInsets.only(bottom: 10.0),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Theme.of(context).primaryColor,
                              width: 1.0
                            )
                          )
                        ),
                        child:
                            Text(DateFormat('yyyy.MM.dd').format(task.due), style: TextStyle(color: Theme.of(context).primaryColor)))));
              }
              list.add(TaskListElement(ValueKey(task.id), _taskBloc, task));
            });
            final List<Task> noDateTasks =
                snapshot.data.where((task) => task.due == null).toList();
            if (noDateTasks.length != 0) {
              noDateTasks.forEach((task) {
                prioList
                    .add(TaskListElement(ValueKey(task.id), _taskBloc, task));
              });
            }
          } else {
            list.add(ListTile(
                leading: FaIcon(FontAwesomeIcons.check),
                title: Text(
                    widget.date != null ? "No tasks for today" : "No tasks")));
          }
          return SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                prioList.length > 0 && list.length > 0
                    ? Padding(
                        padding: const EdgeInsets.only(left: 15.0, top: 40.0, bottom: 10.0),
                        child: Text(
                          "Continuous tasks",
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Theme.of(context).primaryColor),
                        ),
                      )
                    : SizedBox(height: 0),
                ListView(
                    physics: widget.date != null
                        ? NeverScrollableScrollPhysics()
                        : null,
                    shrinkWrap: true,
                    children: prioList),
                SizedBox(height: 20.0),
                prioList.length > 0 && list.length > 0
                    ? Padding(
                      padding: const EdgeInsets.only(left: 15.0, top: 40.0, bottom: 10.0),
                      child: Text(
                          "Dated tasks",
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Theme.of(context).primaryColor),
                        ),
                    )
                    : SizedBox(height: 0),
                ListView(
                  physics: widget.date != null
                      ? NeverScrollableScrollPhysics()
                      : null,
                  shrinkWrap: true,
                  children: list,
                ),
              ],
            ),
          );
        });
  }
}
