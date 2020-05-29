import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mylk/widgets/journal_carousel.dart';
import 'package:mylk/widgets/task_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var message;
    final time = new DateTime.now().hour;
    if (time < 12) {
      message = "Good morning <user>";
    } else if (time >= 12 && time <= 16) {
      message = "Good afternoon <user>";
    } else if (time >= 16 && time <= 20) {
      message = "Good evening <user>";
    } else {
      message = "Good night <user>";
    }
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text('Mylk', style: TextStyle(color: Theme
                .of(context)
                .primaryColor),),
            elevation: 0.0,
            backgroundColor: Colors.white,
            expandedHeight: 300.0,
            floating: false,
            pinned: true,
            actions: <Widget>[
              IconButton(
                icon: FaIcon(FontAwesomeIcons.cog),
                color: Theme
                    .of(context)
                    .primaryColor,
                tooltip: 'Settings',
                onPressed: () => print('settings'),
              )
            ],
            flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  message,
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Theme
                          .of(context)
                          .primaryColor,
                      letterSpacing: 1.0),
                ),
                centerTitle: true,
                titlePadding: EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 70.0),
                background:
                Image.asset('assets/images/bg-7.jpg', fit: BoxFit.cover)),
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
    );
  }
}
