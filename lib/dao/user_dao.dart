import 'dart:async';
import 'package:mylk/database/database.dart';
import 'package:mylk/model/user_model.dart';

class UserDao {
  final dbProvider = DatabaseProvider.dbProvider;

  Future<int> createUser(User user) async {
    final db = await dbProvider.database;
    user.createdAt = DateTime.now();
    var result = db.insert(userTable, user.toDatabaseJson());
    return result;
  }

  Future<User> getUser({List<String> columns, Map<String, dynamic> query}) async {
    final db = await dbProvider.database;

    List<Map<String, dynamic>> result;
    if (query != null) {
      if (query.isNotEmpty)
        result = await db.query(userTable,
            columns: columns,
            where: query["where"],
            whereArgs: query["args"],
            limit: query["limit"],
            orderBy: query["orderBy"] != null ? query["orderBy"] : "-created_at"
        );
    } else {
      result = await db.query(userTable, columns: columns);
    }
    return result.isNotEmpty ? User.fromDatabaseJson(result[0]) : null;
  }

  Future<int> updateUser(User user) async {
    final db = await dbProvider.database;
    user.modifiedAt = DateTime.now();
    var result = await db.update(userTable, user.toDatabaseJson(),
        where: "id = ?", whereArgs: [user.id]);
    return result;
  }

  Future<int> deleteUser(int id) async {
    final db = await dbProvider.database;
    var result = await db.delete(userTable, where: 'id = ?', whereArgs: [id]);
    return result;
  }

  Future deleteAllUsers() async {
    final db = await dbProvider.database;
    var result = await db.delete(
      userTable,
    );
    return result;
  }
}
