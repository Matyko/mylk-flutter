import 'package:flutter/material.dart';
import 'package:mylk/model/journal_model.dart';
import 'package:mylk/widgets/journal_entry_list.dart';

class JournalSummary extends StatefulWidget {
  final Journal journal;

  const JournalSummary(this.journal);

  @override
  _JournalSummaryState createState() => _JournalSummaryState();
}

class _JournalSummaryState extends State<JournalSummary> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 300.0,
      child: JournalEntryList(widget.journal, 5),
    );
  }
}
