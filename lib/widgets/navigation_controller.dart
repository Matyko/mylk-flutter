import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mylk/bloc/bloc_provider.dart';
import 'package:mylk/bloc/task_bloc.dart';
import 'package:mylk/screens/home_screen.dart';
import 'package:mylk/screens/journals_screen.dart';
import 'package:mylk/screens/task_form_screen.dart';
import 'package:mylk/screens/tasks_screen.dart';
import 'package:unicorndial/unicorndial.dart';

class NavigationController extends StatefulWidget {
  @override
  _NavigationControllerState createState() =>
      _NavigationControllerState();
}

class _NavigationControllerState
    extends State<NavigationController> {
  final List<Widget> pages = [
    HomeScreen(
      key: PageStorageKey('home'),
    ),
    TasksScreen(
      key: PageStorageKey('tasks')
    ),
    JournalsScreen(
        key: PageStorageKey('journals')
    )
  ];

  final PageStorageBucket bucket = PageStorageBucket();

  int _selectedIndex = 0;

  Widget _bottomNavigationBar(int selectedIndex) => BottomNavigationBar(
    onTap: (int index) => setState(() => _selectedIndex = index),
    currentIndex: selectedIndex,
    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.home), title: Text('Home')),
      BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.tasks), title: Text('Tasks')),
      BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.bookOpen), title: Text('Journals')),

    ],
  );

  @override
  Widget build(BuildContext context) {
    TaskBloc taskBloc = BlocProvider
        .of(context)
        .taskBloc;
    return Scaffold(
      bottomNavigationBar: _bottomNavigationBar(_selectedIndex),
      body: PageStorage(
        child: pages[_selectedIndex],
        bucket: bucket,
      ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: UnicornDialer(
          parentButtonBackground: Theme.of(context).primaryColor,
          parentButton: Icon(FontAwesomeIcons.plus),
          childButtons: <UnicornButton>[
            UnicornButton(
              currentButton: FloatingActionButton(
                backgroundColor: Theme.of(context).primaryColor,
                heroTag: null,
                mini: true,
                child: FaIcon(FontAwesomeIcons.checkSquare),
                onPressed: () =>
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => TaskFormScreen(null, taskBloc))),
              ),
            ),
            UnicornButton(
              currentButton: FloatingActionButton(
                backgroundColor: Theme.of(context).primaryColor,
                heroTag: null,
                mini: true,
                child: FaIcon(FontAwesomeIcons.book),
                onPressed: () {},
              ),
            )
          ],
        )
    );
  }
}