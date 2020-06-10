import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Mood {
  final String name;
  final IconData icon;
  final int id;
  final int points;

  Mood(this.id, this.name, this.icon, this.points);
}

final List<Mood> baseMoods =  [
  Mood(1, "Happy", FontAwesomeIcons.laughBeam, 2),
  Mood(2, "Relaxed", FontAwesomeIcons.smileBeam, 1),
  Mood(3, "Bored",FontAwesomeIcons.meh, 0),
  Mood(4, "Tense", FontAwesomeIcons.angry, -1),
];