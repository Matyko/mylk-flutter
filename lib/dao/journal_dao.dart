import 'dart:async';
import 'package:mylk/database/database.dart';
import 'package:mylk/model/journal_model.dart';

class JournalDao {
  final dbProvider = DatabaseProvider.dbProvider;

  Future<int> createJournal(Journal journal) async {
    final db = await dbProvider.database;
    journal.createdAt = DateTime.now();
    var result = db.insert(journalTable, journal.toDatabaseJson());
    return result;
  }

  Future<List<Journal>> getJournals({List<String> columns, Map<String, dynamic> query}) async {
    final db = await dbProvider.database;

    List<Map<String, dynamic>> result;
    if (query != null) {
      if (query.isNotEmpty)
        result = await db.query(journalTable,
            columns: columns,
            where: query["where"],
            whereArgs: query["args"],
            limit: query["limit"],
            orderBy: query["orderBy"] != null ? query["orderBy"] : "-created_at"
        );
    } else {
      result = await db.query(journalTable, columns: columns);
    }

    List<Journal> journals = result.isNotEmpty
        ? result.map((item) => Journal.fromDatabaseJson(item)).toList()
        : [];
    return journals;
  }

  Future<int> updateJournal(Journal journal) async {
    final db = await dbProvider.database;
    journal.modifiedAt = DateTime.now();
    var result = await db.update(journalTable, journal.toDatabaseJson(),
        where: "id = ?", whereArgs: [journal.id]);
    return result;
  }

  Future<int> deleteJournal(int id) async {
    final db = await dbProvider.database;
    var result = await db.delete(journalTable, where: 'id = ?', whereArgs: [id]);
    return result;
  }

  Future deleteAllJournals() async {
    final db = await dbProvider.database;
    var result = await db.delete(
      journalTable,
    );
    return result;
  }
}
