import 'package:flutter/material.dart';
import 'package:mylk/bloc/user_bloc.dart';
import 'package:mylk/model/user_model.dart';
import 'package:mylk/state/global_state.dart';
import 'package:provider/provider.dart';

class UserForm extends StatefulWidget {
  final User user;

  const UserForm(this.user);

  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _formKey = GlobalKey<FormState>();
  String _name = "";
  UserBloc _userBloc;

  @override
  Widget build(BuildContext context) {
    _userBloc = UserBloc();
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 50.0, right: 50.0, bottom: 50.0, top: 30.0),
            child: TextFormField(
              initialValue: _name,
              decoration: InputDecoration(labelText: "What's your name?"),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
              onSaved: (String value) {
                setState(() {
                  _name = value;
                });
              },
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: SizedBox(
              width: double.infinity,
              child: RaisedButton(
                  color: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      if (widget.user == null) {
                        User user = User(name: _name);
                        setState(() {
                          _userBloc.addUser(user);
                          Provider.of<UserState>(context).updateUser(user);
                        });
                      } else {
                        widget.user.name = _name;
                        setState(() {
                          _userBloc.updateUser(widget.user);
                        });
                      }
                    }
                  },
                  child: Text(
                    widget.user != null ? 'Update' : 'Continue',
                    style: TextStyle(color: Colors.white),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
