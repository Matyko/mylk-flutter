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
        DateTime day =
            new DateTime(data.date.year, data.date.month, data.date.day);
        if (_reducedData[day] != null) {
          _reducedData[day].add(data.mood.points);
        } else {
          _reducedData[day] = [data.mood.points];
        }
      });
      _reducedData.forEach((key, value) => _chartData.add(DataPoint<DateTime>(
          value: value.reduce((a, b) => a + b / value.length), xAxis: key)));
    }
    return Card(
      child: Container(
        color: Theme.of(context).primaryColor,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Mood chart",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: (_chartData != null && _chartData.length != 0)
                    ? BezierChart(
                        bezierChartScale: BezierChartScale.WEEKLY,
                        fromDate: new DateTime(
                            journalEntries[0].date.year,
                            journalEntries[0].date.month,
                            journalEntries[0].date.day,
                            0,
                            0),
                        toDate: new DateTime(
                            journalEntries[journalEntries.length - 1].date.year,
                            journalEntries[journalEntries.length - 1]
                                .date
                                .month,
                            journalEntries[journalEntries.length - 1].date.day,
                            23,
                            59),
                        series: [
                          BezierLine(
                            data: _chartData,
                          ),
                        ],
                        config: BezierChartConfig(
                          showDataPoints: false,
                          verticalIndicatorStrokeWidth: 3.0,
                          verticalIndicatorColor: Colors.black26,
                          showVerticalIndicator: true,
                          snap: false,
                        ),
                      )
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
