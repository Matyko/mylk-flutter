import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Mood {
  final String name;
  final IconData icon;
  final int id;
  final double points;
  Color color;

  Mood(this.id, this.name, this.icon, this.points, this.color);
}

final List<Mood> baseMoods =  [
  Mood(1, "Happy", FontAwesomeIcons.laughBeam, 2.0, Color(0xFFFFFFFF)),
  Mood(2, "Relaxed", FontAwesomeIcons.smileBeam, 1.0, Color(0xFFFFFFFF)),
  Mood(3, "Bored",FontAwesomeIcons.meh, 0.0, Color(0xFFFFFFFF)),
  Mood(4, "Tense", FontAwesomeIcons.angry, -1.0, Color(0xFFFFFFFF)),
];