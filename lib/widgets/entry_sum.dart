import 'package:flutter/material.dart';

class SumWidget extends StatelessWidget {
  final int sum;
  final String title;

  SumWidget(this.sum, this.title);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).primaryColor,
      child: Column(
        children: <Widget>[
          Text(title),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(sum.toString(), style: TextStyle())
              ],
            ),
          ),
        ],
      ),
    );
  }
}
