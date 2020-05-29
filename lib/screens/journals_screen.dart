import 'package:flutter/material.dart';
import 'package:mylk/widgets/journal_carousel.dart';

class JournalsScreen extends StatelessWidget {
  const JournalsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Journals"),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          JournalCarousel()
        ],
      ),
    );
  }
}
