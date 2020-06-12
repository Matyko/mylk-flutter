import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SumWidget extends StatelessWidget {
  final int sum;
  final String title;

  SumWidget(this.sum, this.title);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).primaryColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Text(title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(sum.toString(), style: TextStyle(color: Colors.white, fontSize: 50.0, fontWeight: FontWeight.bold))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
