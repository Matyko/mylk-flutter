import 'dart:async';
import 'package:mylk/database/database.dart';
import 'package:mylk/model/journal_entry_model.dart';

class JournalEntryDao {
  final dbProvider = DatabaseProvider.dbProvider;

  Future<int> createJournalEntry(JournalEntry journalEntry) async {
    final db = await dbProvider.database;
    journalEntry.createdAt = DateTime.now();
    var result = db.insert(journalEntryTable, journalEntry.toDatabaseJson());
    return result;
  }

  Future<List<JournalEntry>> getJournalEntries({List<String> columns, Map<String, dynamic> query}) async {
    final db = await dbProvider.database;

    List<Map<String, dynamic>> result;
    if (query != null) {
      if (query.isNotEmpty)
        result = await db.query(journalEntryTable,
            columns: columns,
            where: query["where"],
            whereArgs: query["args"],
            limit: query["limit"],
            orderBy: query["orderBy"] != null ? query["orderBy"] : "-date"
        );
    } else {
      result = await db.query(journalEntryTable, columns: columns, orderBy: "-date");
    }

    List<JournalEntry> journalEntries = result.isNotEmpty
        ? result.map((item) => JournalEntry.fromDatabaseJson(item)).toList()
        : [];
    return journalEntries;
  }

  Future<int> updateJournalEntry(JournalEntry journalEntry) async {
    final db = await dbProvider.database;
    journalEntry.modifiedAt = DateTime.now();
    var result = await db.update(journalEntryTable, journalEntry.toDatabaseJson(),
        where: "id = ?", whereArgs: [journalEntry.id]);
    return result;
  }

  Future<int> deleteJournalEntry(int id) async {
    final db = await dbProvider.database;
    var result = await db.delete(journalEntryTable, where: 'id = ?', whereArgs: [id]);
    return result;
  }

  Future deleteAllJournalEntries() async {
    final db = await dbProvider.database;
    var result = await db.delete(
      journalEntryTable,
    );
    return result;
  }
}
