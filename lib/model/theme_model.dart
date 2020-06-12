import 'package:flutter/material.dart';

class MylkTheme {
  int id;
  String name;
  ThemeData themeData;

  MylkTheme({this.id, this.name, this.themeData});

  factory MylkTheme.fromDatabaseJson(Map<String, dynamic> data) => MylkTheme(
      id: data['id'],
      name: data['name'],
      themeData:
          themes.firstWhere((element) => element.id == data['id']).themeData);

  Map<String, dynamic> toDatabaseJson() => {
        "id": this.id,
        "name": this.name,
      };
}

List<List<Color>> colors = [
  [Colors.blueGrey.shade500, Colors.blueGrey.shade300, Colors.yellow.shade800],
  [Colors.red.shade300, Colors.red.shade100, Colors.green.shade300],
  [Colors.purple.shade300, Colors.purple.shade100, Colors.deepOrange.shade300],
  [Colors.blue.shade300, Colors.blue.shade100, Colors.red.shade300],
  [Colors.green.shade300, Colors.green.shade100, Colors.red.shade300],
  [Colors.yellow.shade800, Colors.yellow.shade700, Colors.blueGrey.shade500],
  [Colors.deepOrange.shade300, Colors.deepOrange.shade100, Colors.purple.shade300],
];

List<ThemeData> themeDataArray = [
  ThemeData(
      primaryColor: colors[0][0],
      backgroundColor: colors[0][1],
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: colors[0][2]
      ),
      fontFamily: 'Quicksand',
      textTheme: TextTheme(headline6: TextStyle(fontWeight: FontWeight.bold))),
  ThemeData(
      primaryColor: colors[1][0],
      backgroundColor: colors[1][1],
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: colors[1][2]
      ),
      fontFamily: 'Quicksand',
      textTheme: TextTheme(headline6: TextStyle(fontWeight: FontWeight.bold))),
  ThemeData(
      primaryColor: colors[2][0],
      backgroundColor: colors[2][1],
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: colors[2][2]
      ),
      fontFamily: 'Quicksand',
      textTheme: TextTheme(headline6: TextStyle(fontWeight: FontWeight.bold))),
  ThemeData(
      primaryColor: colors[3][0],
      backgroundColor: colors[3][1],
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: colors[3][2]
      ),
      fontFamily: 'Quicksand',
      textTheme: TextTheme(headline6: TextStyle(fontWeight: FontWeight.bold))),
  ThemeData(
      primaryColor: colors[4][0],
      backgroundColor: colors[4][1],
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: colors[4][2]
      ),
      fontFamily: 'Quicksand',
      textTheme: TextTheme(headline6: TextStyle(fontWeight: FontWeight.bold))),
  ThemeData(
      primaryColor: colors[5][0],
      backgroundColor: colors[5][1],
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: colors[5][2]
      ),
      fontFamily: 'Quicksand',
      textTheme: TextTheme(headline6: TextStyle(fontWeight: FontWeight.bold))),
  ThemeData(
      primaryColor: colors[6][0],
      backgroundColor: colors[6][1],
      fontFamily: 'Quicksand',
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colors[6][2]
      ),
      textTheme: TextTheme(headline6: TextStyle(fontWeight: FontWeight.bold))),
];

List<MylkTheme> themes = [
  MylkTheme(id: 1, name: "grey", themeData: themeDataArray[0]),
  MylkTheme(id: 2, name: "red", themeData: themeDataArray[1]),
  MylkTheme(id: 3, name: "purple", themeData: themeDataArray[2]),
  MylkTheme(id: 4, name: "blue", themeData: themeDataArray[3]),
  MylkTheme(id: 5, name: "green", themeData: themeDataArray[4]),
  MylkTheme(id: 6, name: "yellow", themeData: themeDataArray[5]),
  MylkTheme(id: 7, name: "orange", themeData: themeDataArray[6])
];
