import 'package:flutter/material.dart';
import 'package:mylk/model/journal_entry_model.dart';
import 'package:pie_chart/pie_chart.dart';

class MoodEntryChart extends StatelessWidget {
  final List<JournalEntry> journalEntries;

  MoodEntryChart(this.journalEntries);

  @override
  Widget build(BuildContext context) {
    Map<String, double> _chartData = Map<String, double>();
    if (journalEntries != null && journalEntries.length != 0) {
      journalEntries.forEach((data) {
        if (_chartData[data.mood.name] != null) {
            _chartData[data.mood.name]++;
        } else {
            _chartData[data.mood.name] = 1;
        }
      });
    }
    return Card(
      child: Container(
        color: Theme.of(context).primaryColor,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Mood breakdown",
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: (journalEntries != null && journalEntries.length != 0)
                    ?  PieChart(
                  dataMap: _chartData,
                  legendStyle: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),
                  animationDuration: Duration(milliseconds: 0),
                  chartValueStyle: defaultChartValueStyle.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
                  colorList: <Color>[
                    Colors.white,
                    Colors.white70,
                    Colors.white54,
                    Colors.white38,
                    Colors.white24
                  ],
                ) : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
