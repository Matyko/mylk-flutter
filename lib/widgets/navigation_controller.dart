import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mylk/screens/home_screen.dart';
import 'package:mylk/screens/journal_entry_form_screen.dart';
import 'package:mylk/screens/journal_form_screen.dart';
import 'package:mylk/screens/journals_screen.dart';
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
    HomeScreen(
      key: PageStorageKey('home'),
    ),
    TasksScreen(key: PageStorageKey('tasks')),
    JournalsScreen(key: PageStorageKey('journals'))
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
    final globalState = Provider.of<GlobalState>(context);
    List<UnicornButton> buttons = List<UnicornButton>();
    if (_selectedIndex == 0) {
      buttons.add(
        UnicornButton(
          currentButton: FloatingActionButton(
            backgroundColor: Theme.of(context).primaryColor,
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
            backgroundColor: Theme.of(context).primaryColor,
            heroTag: null,
            mini: true,
            child: FaIcon(FontAwesomeIcons.book),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => JournalFormSceen(null))),
          ),
        ),
      );
      buttons.add(UnicornButton(
        currentButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          heroTag: null,
          mini: true,
          child: FaIcon(FontAwesomeIcons.fileAlt),
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (_) => JournalEntryFormScreen(null, globalState.currentJournal, null))),
        ),
      ));
    } else if (_selectedIndex == 2) {
      buttons.add(
        UnicornButton(
          currentButton: FloatingActionButton(
            backgroundColor: Theme.of(context).primaryColor,
            heroTag: null,
            mini: true,
            child: FaIcon(FontAwesomeIcons.book),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => JournalFormSceen(null))),
          ),
        ),
      );
      buttons.add(UnicornButton(
        currentButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          heroTag: null,
          mini: true,
          child: FaIcon(FontAwesomeIcons.fileAlt),
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (_) => JournalEntryFormScreen(null, globalState.currentJournal, null))),
        ),
      ));
    }
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
          childButtons: buttons,
          onMainButtonPressed: () {
            if (_selectedIndex == 1) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => TaskFormScreen(null)));
            }
          },
        ));
  }
}
