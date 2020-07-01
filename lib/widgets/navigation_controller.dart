import 'package:flutter/material.dart';
import 'package:mylk/model/user_model.dart';
import 'package:mylk/repository/user_repository.dart';
import 'package:mylk/screens/home_screen.dart';
import 'package:mylk/screens/journals_screen.dart';
import 'package:mylk/screens/loading_screen.dart';
import 'package:mylk/screens/setup_screen.dart';
import 'package:mylk/screens/statistics_screen.dart';
import 'package:mylk/screens/tasks_screen.dart';
import 'package:mylk/state/global_state.dart';
import 'package:mylk/widgets/mylk_bottom_navigation.dart';
import 'package:mylk/widgets/mylk_speed_dial.dart';
import 'package:provider/provider.dart';

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

  void updateIndex(int newIdx) {
    setState(() {
      _selectedIndex = newIdx;
    });
  }

  void loadData() async {
    _userRepository = UserRepository();
    User _user = await _userRepository.getUser();
    await Future.delayed(const Duration(seconds: 2), () {});
    if (_user != null &&
        Provider.of<UserState>(context, listen: false).user == null) {
      Provider.of<UserState>(context, listen: false).updateUser(_user);
    }
    setState(() {
      this.user = _user;
      this.ready = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserState>(
      builder: (context, model, widget) {
        if (model.user != user) {
          user = model.user;
        }
        return Scaffold(
            bottomNavigationBar: (ready && user != null)
                ? MylkBottomNavigationBar(_selectedIndex, updateIndex)
                : null,
            body: PageStorage(
              child: pages[ready ? user != null ? _selectedIndex : 4 : 5],
              bucket: bucket,
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
            floatingActionButton: (ready && user != null)
                ? Container(padding: EdgeInsets.only(bottom: 20.0), child: MylkSpeedDial(_selectedIndex))
                : null);
      },
    );
  }
}
