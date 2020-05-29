import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Mood {
  final String name;
  final IconData icon;

  Mood(this.name, this.icon);
}

final List<Mood> baseMoods =  [
  Mood( "Happy", FontAwesomeIcons.laughBeam),
  Mood("Relaxed", FontAwesomeIcons.smileBeam),
  Mood("Bored",FontAwesomeIcons.meh),
  Mood("Tense", FontAwesomeIcons.angry),
];