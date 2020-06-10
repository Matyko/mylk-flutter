import 'package:flutter/material.dart';
import 'package:mylk/widgets/user_form.dart';

class SetupScreen extends StatefulWidget {
  const SetupScreen({Key key}) : super(key: key);

  @override
  _SetupScreenState createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(milliseconds: 100), () {
      if (!mounted) return;
      setState(() {
        _visible = true;
      });
    });
    return AnimatedOpacity(
      opacity: _visible ? 1.0 : 0.0,
      duration: Duration(milliseconds: 300),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Welcome", style: TextStyle(fontSize: 20.0),),
            UserForm(null)
          ],
        )
      ),
    );
  }
}
