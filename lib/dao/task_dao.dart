import 'dart:async';
import 'package:mylk/database/database.dart';
import 'package:mylk/model/task_model.dart';

class TaskDao {
  final dbProvider = DatabaseProvider.dbProvider;

  Future<int> createTask(Task task) async {
    final db = await dbProvider.database;
    task.createdAt = DateTime.now();
    return db.insert(taskTable, task.toDatabaseJson());
  }

  Future<List<Task>> getTasks({List<String> columns, Map<String, dynamic> query}) async {
    final db = await dbProvider.database;

    List<Map<String, dynamic>> result;
    if (query != null) {
      if (query.isNotEmpty)
        result = await db.query(taskTable,
            columns: columns,
            where: query["where"],
            whereArgs: query["args"],
            limit: query["limit"],
            orderBy: query["orderBy"] != null ? query["orderBy"] : "-due"
        );
    } else {
      result = await db.query(taskTable, columns: columns);
    }

    List<Task> tasks = result.isNotEmpty
        ? result.map((item) => Task.fromDatabaseJson(item)).toList()
        : [];
    tasks.sort((a,b) {
      if (a.due == null && b.due == null) return 0;
      if (a.due == null) return -1;
      if (b.due == null) return 1;
      return a.due.compareTo(b.due);
    });
    return tasks;
  }

  Future<int> updateTask(Task task) async {
    final db = await dbProvider.database;
    task.modifiedAt = DateTime.now();
    var result = await db.update(taskTable, task.toDatabaseJson(),
        where: "id = ?", whereArgs: [task.id]);
    return result;
  }

  Future<int> deleteTask(int id) async {
    final db = await dbProvider.database;
    var result = await db.delete(taskTable, where: 'id = ?', whereArgs: [id]);
    return result;
  }

  Future deleteAllTasks() async {
    final db = await dbProvider.database;
    var result = await db.delete(
      taskTable,
    );
    return result;
  }
}
