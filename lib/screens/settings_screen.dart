import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mylk/bloc/user_bloc.dart';
import 'package:mylk/bloc/user_bloc.dart';
import 'package:mylk/widgets/color_picker.dart';
import 'package:mylk/widgets/user_form.dart';

List<StaggeredTile> _staggeredTiles = const <StaggeredTile>[
  StaggeredTile.count(2, 1),
  StaggeredTile.count(2, 1),
];

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    final UserBloc userBloc = UserBloc();
    userBloc.getUser();
    if (!_visible) {
      Future.delayed(Duration(milliseconds: 100), () {
        if (!mounted) return;
        setState(() {
          _visible = true;
        });
      });
    }
    return new Scaffold(
        appBar: AppBar(
          leading: BackButton(
            color: Colors.white,
          ),
          title: Text("Settings", style: TextStyle(color: Colors.white, fontFamily: 'Pacifico')),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: new StaggeredGridView.count(
            crossAxisCount: 2,
            staggeredTiles: _staggeredTiles,
            children: <Widget>[
              StreamBuilder(
                  stream: userBloc.user,
                  builder: (context, snapshot) {
                    return Card(
                      child: snapshot.data != null
                          ? UserForm(snapshot.data)
                          : null,
                    );
                  }),
              StreamBuilder(
                  stream: userBloc.user,
                  builder: (context, snapshot) {
                    return Card(
                      child: snapshot.data != null
                          ? ColorPicker()
                          : null,
                    );
                  }),
            ],
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0,
            padding: const EdgeInsets.all(4.0),
          ),
        ));
  }
}
