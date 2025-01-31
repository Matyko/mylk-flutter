import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mylk/screens/journal_entry_form_screen.dart';
import 'package:mylk/screens/journal_form_screen.dart';
import 'package:mylk/screens/task_form_screen.dart';
import 'package:mylk/state/global_state.dart';
import 'package:provider/provider.dart';

class MylkSpeedDial extends StatefulWidget {
  final int selectedIndex;

  const MylkSpeedDial(this.selectedIndex);

  @override
  _MylkSpeedDialState createState() => _MylkSpeedDialState();
}

class _MylkSpeedDialState extends State<MylkSpeedDial> {
  @override
  Widget build(BuildContext context) {
    return Consumer<JournalState>(
      builder: (context, model, widget) {
        List<SpeedDialChild> children = [
          SpeedDialChild(
              label: "Add task",
              labelBackgroundColor: Theme.of(context).floatingActionButtonTheme.backgroundColor,
              labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              child: FloatingActionButton(
                  heroTag: "tf",
                  onPressed: () {
                    showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (context) => TaskFormScreen(null)
                    );
                  },
                  child: FaIcon(FontAwesomeIcons.checkSquare))),
          SpeedDialChild(
              label: "Create journal",
              labelBackgroundColor: Theme.of(context).floatingActionButtonTheme.backgroundColor,
              labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              child: FloatingActionButton(
                  heroTag: "jf",
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => JournalFormSceen(null)));
                  },
                  child: FaIcon(FontAwesomeIcons.book)))
        ];
        if (model.currentJournal != null) {
          children.add(SpeedDialChild(
              label: "Add entry to ${model.currentJournal.title}",
              labelBackgroundColor: Theme.of(context).floatingActionButtonTheme.backgroundColor,
              labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              child: FloatingActionButton(
                  heroTag: "jef",
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => JournalEntryFormScreen(
                                null, model.currentJournal, null)));
                  },
                  child: FaIcon(FontAwesomeIcons.fileAlt))));
        }
        return SpeedDial(
            animatedIcon: AnimatedIcons.menu_close, children: children);
      },
    );
  }
}
