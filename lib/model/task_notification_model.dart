import 'package:flutter/material.dart';

class TaskNotification {
  final int id;
  final String title;
  final String body;
  final String payload;

  TaskNotification({
    @required this.id,
    @required this.title,
    @required this.body,
    @required this.payload,
  });
}
