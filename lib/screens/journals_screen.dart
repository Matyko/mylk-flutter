import 'package:flutter/material.dart';
import 'package:mylk/state/global_state.dart';
import 'package:mylk/widgets/journal_carousel.dart';
import 'package:mylk/widgets/journal_entry_list.dart';
import 'package:provider/provider.dart';

class JournalsScreen extends StatefulWidget {
  const JournalsScreen({Key key}) : super(key: key);

  @override
  _JournalsScreenState createState() => _JournalsScreenState();
}

class _JournalsScreenState extends State<JournalsScreen> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(milliseconds: 100), () {
      if (!mounted) return;
      setState(() {
        _visible = true;
      });
    });
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Journals", style: TextStyle(fontFamily: 'Pacifico')),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: AnimatedOpacity(
          opacity: _visible ? 1.0 : 0.0,
          duration: Duration(milliseconds: 300),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              JournalCarousel(),
              SizedBox(height: 10.0,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: Text("Latest entries", style: TextStyle(fontWeight: FontWeight.bold),),
              ),
              Expanded(
                child: Consumer<JournalState>(
                    builder: (context, model, widget) {
                      return JournalEntryList(model.currentJournal, 3);
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
