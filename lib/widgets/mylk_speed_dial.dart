import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MylkSpeedDial extends StatefulWidget {
  final int selectedIndex;

  const MylkSpeedDial(this.selectedIndex);

  @override
  _MylkSpeedDialState createState() => _MylkSpeedDialState();
}

class _MylkSpeedDialState extends State<MylkSpeedDial> {
  @override
  Widget build(BuildContext context) {
    return SpeedDial(animatedIcon: AnimatedIcons.menu_close, children: [
      SpeedDialChild(
          child: FloatingActionButton(
              onPressed: () {}, child: FaIcon(FontAwesomeIcons.checkSquare))),
      SpeedDialChild(
          child: FloatingActionButton(
              onPressed: () {}, child: FaIcon(FontAwesomeIcons.book))),
      SpeedDialChild(
          child: FloatingActionButton(
              onPressed: () {}, child: FaIcon(FontAwesomeIcons.fileAlt)))
    ]);
  }
}
