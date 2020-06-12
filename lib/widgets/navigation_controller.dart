import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mylk/model/user_model.dart';
import 'package:mylk/repository/user_repository.dart';
import 'package:mylk/screens/home_screen.dart';
import 'package:mylk/screens/journal_entry_form_screen.dart';
import 'package:mylk/screens/journal_form_screen.dart';
import 'package:mylk/screens/journals_screen.dart';
import 'package:mylk/screens/loading_screen.dart';
import 'package:mylk/screens/setup_screen.dart';
import 'package:mylk/screens/statistics_screen.dart';
import 'package:mylk/screens/task_form_screen.dart';
import 'package:mylk/screens/tasks_screen.dart';
import 'package:mylk/state/global_state.dart';
import 'package:provider/provider.dart';
import 'package:unicorndial/unicorndial.dart';

class NavigationController extends StatefulWidget {
  @override
  _NavigationControllerState createState() => _NavigationControllerState();
}

class _NavigationControllerState extends State<NavigationController> {
  final List<Widget> pages = [
    HomeScreen(key: PageStorageKey('home')),
    TasksScreen(key: PageStorageKey('tasks')),
    JournalsScreen(key: PageStorageKey('journals')),
    StatisticsScreen(key: PageStorageKey('statistics')),
    SetupScreen(key: PageStorageKey('setup')),
    LoadingScreen(key: PageStorageKey('loading')),
  ];

  final PageStorageBucket bucket = PageStorageBucket();

  int _selectedIndex = 0;
  bool ready = false;
  User user;
  UserRepository _userRepository;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    _userRepository = UserRepository();
    User _user = await _userRepository.getUser();
    await Future.delayed(const Duration(seconds: 2), () {});
    if (_user != null && Provider.of<UserState>(context, listen: false).user == null) {
      Provider.of<UserState>(context, listen: false).updateUser(_user);
    }
    setState(() {
      this.user = _user;
      this.ready = true;
    });
  }

  Widget _bottomNavigationBar(int selectedIndex) => CurvedNavigationBar(
        height: 60.0,
        buttonBackgroundColor: Theme.of(context).primaryColor,
        onTap: (int index) => setState(() => _selectedIndex = index),
        index: _selectedIndex,
        color: Theme.of(context).primaryColor,
        backgroundColor: Colors.white,
        items: <Widget>[
          Container(
            padding: EdgeInsets.only(top: _selectedIndex == 0 ? 0 : 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                FaIcon(FontAwesomeIcons.home, size: 20.0, color: Colors.white)
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: _selectedIndex == 1 ? 0 : 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                FaIcon(FontAwesomeIcons.tasks, size: 20.0, color: Colors.white)
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: _selectedIndex == 2 ? 0 : 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                FaIcon(FontAwesomeIcons.bookOpen,
                    size: 20.0, color: Colors.white)
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: _selectedIndex == 3 ? 0 : 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                FaIcon(FontAwesomeIcons.chartLine,
                    size: 20.0, color: Colors.white)
              ],
            ),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    final userState = Provider.of<UserState>(context);
    final journalState = Provider.of<JournalState>(context);
    List<UnicornButton> buttons = List<UnicornButton>();
    if (_selectedIndex == 0) {
      buttons.add(
        UnicornButton(
          currentButton: FloatingActionButton(
            backgroundColor: Theme.of(context).floatingActionButtonTheme.backgroundColor,
            heroTag: null,
            mini: true,
            child: FaIcon(FontAwesomeIcons.checkSquare),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => TaskFormScreen(null))),
          ),
        ),
      );
      buttons.add(
        UnicornButton(
          currentButton: FloatingActionButton(
            backgroundColor: Theme.of(context).floatingActionButtonTheme.backgroundColor,
            heroTag: null,
            mini: true,
            child: FaIcon(FontAwesomeIcons.book),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => JournalFormSceen(null))),
          ),
        ),
      );
      if (journalState.currentJournal != null) {
        buttons.add(UnicornButton(
          currentButton: FloatingActionButton(
            backgroundColor: Theme.of(context).floatingActionButtonTheme.backgroundColor,
            heroTag: null,
            mini: true,
            child: FaIcon(FontAwesomeIcons.fileAlt),
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => JournalEntryFormScreen(
                        null, journalState.currentJournal, null))),
          ),
        ));
      }
    } else if (_selectedIndex == 2) {
      buttons.add(
        UnicornButton(
          currentButton: FloatingActionButton(
            backgroundColor: Theme.of(context).floatingActionButtonTheme.backgroundColor,
            heroTag: null,
            mini: true,
            child: FaIcon(FontAwesomeIcons.book),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => JournalFormSceen(null))),
          ),
        ),
      );
      if (journalState.currentJournal != null) {
        buttons.add(UnicornButton(
          currentButton: FloatingActionButton(
            backgroundColor: Theme.of(context).floatingActionButtonTheme.backgroundColor,
            heroTag: null,
            mini: true,
            child: FaIcon(FontAwesomeIcons.fileAlt),
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => JournalEntryFormScreen(
                        null, journalState.currentJournal, null))),
          ),
        ));
      }
    }
    return Consumer<UserState>(
      builder: (context, model, widget) {
        if (model.user != user) {
          user = model.user;
        }
        return Scaffold(
            bottomNavigationBar: (ready && user != null)
                ? _bottomNavigationBar(_selectedIndex)
                : null,
            body: ShaderMask(
              shaderCallback: (Rect bounds) {
                return LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment(0.0, 0.5),
                  colors: <Color>[
                    _selectedIndex == 4 || _selectedIndex == 5
                        ? Colors.transparent
                        : Colors.white,
                    Colors.transparent
                  ],
                ).createShader(bounds);
              },
              blendMode: BlendMode.lighten,
              child: PageStorage(
                child: pages[ready ? user != null ? _selectedIndex : 4 : 5],
                bucket: bucket,
              ),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            floatingActionButton: (ready && user != null)
                ? UnicornDialer(
                    parentButtonBackground: Theme.of(context).floatingActionButtonTheme.backgroundColor,
                    parentButton: Icon(FontAwesomeIcons.plus),
                    childButtons: buttons,
                    onMainButtonPressed: () {
                      if (_selectedIndex == 1) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => TaskFormScreen(null)));
                      }
                    },
                  )
                : null);
      },
    );
  }
}
