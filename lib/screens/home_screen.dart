import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mylk/screens/settings_screen.dart';
import 'package:mylk/screens/setup_screen.dart';
import 'package:mylk/state/global_state.dart';
import 'package:mylk/widgets/journal_carousel.dart';
import 'package:mylk/widgets/task_list.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    String message;
    final globalState = Provider.of<UserState>(context);
    final user = globalState.user;
    final time = new DateTime.now().hour;
    if (time < 12) {
      message = "Good morning,";
    } else if (time >= 12 && time <= 16) {
      message = "Good afternoon,";
    } else if (time >= 16 && time <= 20) {
      message = "Good evening,";
    } else {
      message = "Good night,";
    }
    if (!_visible) {
      Future.delayed(Duration(milliseconds: 100), () {
        if (!mounted) return;
        setState(() {
          _visible = true;
        });
      });
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnimatedOpacity(
        opacity: _visible ? 1.0 : 0.0,
        duration: Duration(milliseconds: 300),
        child: Container(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                elevation: 0.0,
                backgroundColor: Colors.white,
                expandedHeight: 150.0,
                actions: <Widget>[
                  IconButton(
                    icon: FaIcon(FontAwesomeIcons.slidersH),
                    color: Theme
                        .of(context)
                        .primaryColor,
                    tooltip: 'Settings',
                    onPressed: () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => SettingsScreen())),
                  )
                ],
                flexibleSpace: FlexibleSpaceBar(
                    title: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            message,
                            style: TextStyle(
                                fontSize: 20.0,
                                color: Theme
                                    .of(context)
                                    .primaryColor,
                                letterSpacing: 1.0),
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            user.name,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            )
                          )
                        ],
                      ),
                    ),
                    titlePadding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Tasks for today",
                      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  TaskList(date: DateTime.now()),
                  SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Your journals",
                      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  JournalCarousel(),
                  SizedBox(
                    height: 20.0,
                  ),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
