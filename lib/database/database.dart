import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

final taskTable = 'task';
final journalTable = 'journal';
final journalEntryTable = 'journal_entry';
final userTable = 'user';

class DatabaseProvider {
  static final DatabaseProvider dbProvider = DatabaseProvider();
  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await createDatabase();
    return _database;
  }

  createDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "mylk.db");
    var database = await openDatabase(path,
        version: 1, onCreate: initDB, onUpgrade: onUpgrade);
    return database;
  }

  void onUpgrade(Database database, int oldVersion, int newVersion) {
    if (newVersion > oldVersion) {}
  }

  void initDB(Database database, int version) async {
    await database.execute("DROP TABLE IF EXISTS $taskTable");
    await database.execute("DROP TABLE IF EXISTS $journalTable");
    await database.execute("DROP TABLE IF EXISTS $journalEntryTable");
    await database.execute("DROP TABLE IF EXISTS $userTable");
    await database.execute("CREATE TABLE $userTable ("
        "id INTEGER PRIMARY KEY, "
        "name TEXT, "
        "email TEXT, "
        "created_at INTEGER, "
        "modified_at INTEGER "
        ")");
    await database.execute("CREATE TABLE $taskTable ("
        "id INTEGER PRIMARY KEY, "
        "title TEXT, "
        "due INTEGER, "
        "created_at INTEGER, "
        "modified_at INTEGER, "
        "is_done INTEGER, "
        "done_at INTEGER "
        ")");
    await database.execute("CREATE TABLE $journalTable ("
        "id INTEGER PRIMARY KEY, "
        "created_at INTEGER, "
        "modified_at INTEGER, "
        "title TEXT, "
        "background_image TEXT "
        ")");
    await database.execute("CREATE TABLE $journalEntryTable ("
        "id INTEGER PRIMARY KEY, "
        "journal_id INTEGER, "
        "created_at INTEGER, "
        "modified_at INTEGER, "
        "mood_id INTEGER, "
        "title TEXT, "
        "content TEXT "
        ")");
  }
}
