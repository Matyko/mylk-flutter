import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mylk/bloc/bloc_provider.dart';
import 'package:mylk/bloc/journal_bloc.dart';
import 'package:mylk/bloc/journal_entry_bloc.dart';
import 'package:mylk/model/journal_model.dart';
import 'package:mylk/repository/journal_repository.dart';
import 'package:mylk/screens/journal_form_screen.dart';
import 'package:mylk/state/global_state.dart';
import 'package:provider/provider.dart';
import 'journal_illustration.dart';

class JournalCarousel extends StatefulWidget {

  const JournalCarousel();

  @override
  _JournalCarouselState createState() => _JournalCarouselState();
}

class _JournalCarouselState extends State<JournalCarousel> {
  JournalBloc _journalBloc;
  JournalEntryBloc _journalEntryBloc;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      viewportFraction: 0.6
    );
    loadFirstJournalToGlobalState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final journalBloc = BlocProvider.of(context).journalBloc;
    final journalEntryBloc = BlocProvider.of(context).journalEntryBloc;
    if (_journalBloc != journalBloc) {
      _journalBloc = journalBloc;
      _journalBloc.getJournals();
    }
    if (_journalEntryBloc != journalEntryBloc) {
      _journalEntryBloc = journalEntryBloc;
      _journalEntryBloc.getJournalEntries();
    }
  }

  loadFirstJournalToGlobalState() async {
    JournalRepository journalRepository = JournalRepository();
    List<Journal> journals = await journalRepository.getAllJournals();
    if (journals != null && journals.length != 0) {
      Provider.of<GlobalState>(context, listen: false).updateCurrentJournal(journals[0]);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 300.0,
        padding: EdgeInsets.only(bottom: 10.0),
        child: Consumer<GlobalState>(
          builder: (context, model, widget) => StreamBuilder(
              stream: _journalBloc.journals,
              builder:
                  (BuildContext context, AsyncSnapshot<List<Journal>> snapshot) {
                List<Widget> list = new List<Widget>();
                if (snapshot != null &&
                    snapshot.data != null &&
                    snapshot.data.length != 0) {
                  snapshot.data.forEach((journal) {
                    list.add(JournalIllustration(journal));
                  });
                } else {
                  list.add(
                    Container(
                      margin: EdgeInsets.all(40.0),
                      decoration: BoxDecoration(
                          color: Colors.black26,
                          boxShadow: [
                            new BoxShadow(
                                color: Colors.black12,
                                blurRadius: 5.0)
                          ],
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(2.0),
                              bottomLeft: Radius.circular(2.0),
                              topRight: Radius.circular(20.0),
                              bottomRight:
                              Radius.circular(20.0))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FlatButton(
                            onPressed: () => Navigator.push(context,
                                MaterialPageRoute(builder: (_) => JournalFormSceen(null))),
                            child: FaIcon(FontAwesomeIcons.plusCircle, color: Colors.white70, size: 50.0,),
                          )
                        ],
                      ),
                    )
                  );
                }
                return PageView(
                  controller: _pageController,
                  scrollDirection: Axis.horizontal,
                  children: list,
                  onPageChanged: (pageIdx) {
                    if (!mounted) return;
                    model.updateCurrentJournal(snapshot.data[pageIdx]);
                  },
                );
              }),
        ));
  }
}
