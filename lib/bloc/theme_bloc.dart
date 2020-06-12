import 'dart:async';

import 'package:flutter/material.dart';

class ThemeBloc {
  ThemeData _themeData;
  ThemeData get currentTheme => _themeData;

  final _themeDataController = StreamController<ThemeData>();

  Stream<ThemeData> get themeDataStream => _themeDataController.stream;

  void setTheme(ThemeData themeData) {
    _themeData = themeData;
    _themeDataController.sink.add(themeData);
  }

  void dispose() {
    _themeDataController.close();
  }
}