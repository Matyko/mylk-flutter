import 'package:flutter/material.dart';
import 'package:mylk/widgets/task_list.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tasks"),
        centerTitle: true
      ),
      body: Column(
        children: <Widget>[
          TaskList(date: null),
        ],
      ),
    );
  }
}
