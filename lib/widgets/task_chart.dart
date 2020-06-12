import 'package:bezier_chart/bezier_chart.dart';
import 'package:flutter/material.dart';
import 'package:mylk/model/task_model.dart';

class TaskChart extends StatelessWidget {
  final List<Task> taskList;

  const TaskChart(this.taskList);

  @override
  Widget build(BuildContext context) {
    List<DataPoint<DateTime>> _chartData = List<DataPoint<DateTime>>();
    if (taskList != null && taskList.length != 0) {
      Map<DateTime, double> _reducedData = Map<DateTime, double>();
      taskList.forEach((data) {
        if (data.isDone) {
          DateTime day = new DateTime(data.doneAt.year, data.doneAt.month, data.doneAt.day);
          if (_reducedData[day] != null) {
            _reducedData[day]++;
          } else {
            _reducedData[day] = 1;
          }
        }
      });
      _reducedData.forEach((key, value) => _chartData.add(DataPoint<DateTime>(value: value, xAxis: key)));
    }
    return Card(
      child: Container(
        color: Theme.of(context).primaryColor,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Completed tasks / day", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: (_chartData != null && _chartData.length != 0) ? BezierChart(
                  bezierChartScale: BezierChartScale.WEEKLY,
                  fromDate: new DateTime(taskList[0].createdAt.year, taskList[0].createdAt.month, taskList[0].createdAt.day, 0, 0),
                  toDate: new DateTime(taskList[taskList.length - 1].createdAt.year, taskList[taskList.length - 1].createdAt.month, taskList[taskList.length - 1].createdAt.day, 23, 59),
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
