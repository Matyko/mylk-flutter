import 'package:bezier_chart/bezier_chart.dart';
import 'package:flutter/material.dart';
import 'package:mylk/model/journal_entry_model.dart';

class MoodChart extends StatelessWidget {
  final List<JournalEntry> journalEntries;

  MoodChart(this.journalEntries);

  @override
  Widget build(BuildContext context) {
    List<DataPoint<DateTime>> _chartData = List<DataPoint<DateTime>>();
    if (journalEntries != null && journalEntries.length != 0) {
      Map<DateTime, List<double>> _reducedData = Map<DateTime, List<double>>();
      journalEntries.forEach((data) {
        DateTime day = new DateTime(data.createdAt.year, data.createdAt.month, data.createdAt.day);
        if (_reducedData[day] != null) {
          _reducedData[day].add(data.mood.points);
        } else {
          _reducedData[day] = [data.mood.points];
        }
      });
      _reducedData.forEach((key, value) => _chartData.add(DataPoint<DateTime>(value: value.reduce((a, b) => a + b / value.length), xAxis: key)));
    }
    return Card(
      child: Container(
        color: Theme.of(context).primaryColor,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Mood chart", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child:  (_chartData != null && _chartData.length != 0) ? BezierChart(
                  bezierChartScale: BezierChartScale.WEEKLY,
                  fromDate: new DateTime(journalEntries[0].createdAt.year, journalEntries[0].createdAt.month, journalEntries[0].createdAt.day, 0, 0),
                  toDate: new DateTime(journalEntries[journalEntries.length - 1].createdAt.year, journalEntries[journalEntries.length - 1].createdAt.month, journalEntries[journalEntries.length - 1].createdAt.day, 23, 59),
                  series: [
                    BezierLine(
                      data: _chartData,
                    ),
                  ],
                  config: BezierChartConfig(
                    verticalIndicatorStrokeWidth: 3.0,
                    verticalIndicatorColor: Colors.black26,
                    showVerticalIndicator: true,
                    snap: false,
                  ),
                ) : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
