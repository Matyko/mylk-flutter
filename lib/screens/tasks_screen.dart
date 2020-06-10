import 'package:flutter/material.dart';
import 'package:mylk/widgets/task_list.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({Key key}) : super(key: key);

  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(milliseconds: 100), () {
      if (!mounted) return;
      setState(() {
        _visible = true;
      });
    });
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Tasks", style: TextStyle(fontFamily: 'Pacifico')),
        centerTitle: true
      ),
      body: AnimatedOpacity(
        opacity: _visible ? 1.0 : 0.0,
        duration: Duration(milliseconds: 300),
        child: Column(
          children: <Widget>[
            TaskList(date: null),
          ],
        ),
      ),
    );
  }
}
