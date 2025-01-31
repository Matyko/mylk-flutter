import 'package:flutter/material.dart';
import 'package:mylk/widgets/color_picker.dart';
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
    if (!_visible) {
      Future.delayed(Duration(milliseconds: 100), () {
        if (!mounted) return;
        setState(() {
          _visible = true;
        });
      });
    }
    return AnimatedOpacity(
      opacity: _visible ? 1.0 : 0.0,
      duration: Duration(milliseconds: 300),
      child: Container(
          padding: MediaQuery.of(context).viewInsets,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Welcome",
                style: TextStyle(
                    fontSize: 50.0,
                    fontFamily: 'Pacifico',
                    color: Theme.of(context).primaryColor),
              ),
              Expanded(
                  flex: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: UserForm(null),
                  )),
            ],
          )),
    );
  }
}
