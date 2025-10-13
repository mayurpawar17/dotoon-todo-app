import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../domain/todo_Model.dart';

class DatabaseHelper {
  static const _databaseName = "TodoDatabase.db";
  static const _databaseVersion = 1;

  static const table = 'todo_table';

  static const columnId = 'id';
  static const columnTitle = 'title';
  static const columnDescription = 'description';
  static const columnPriority = 'priority';
  static const columnDate = 'date';
  static const columnIsCompleted = 'isCompleted';

  // Make this a singleton class
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Only have a single app-wide reference to the database
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Open the database (and create it if it doesn't exist)
  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table (
        $columnId TEXT PRIMARY KEY,
        $columnTitle TEXT NOT NULL,
        $columnDescription TEXT,
        $columnPriority TEXT,
        $columnDate TEXT NOT NULL,
        $columnIsCompleted INTEGER NOT NULL
        
      )
    ''');
  }

  // This is called when the database is upgraded
  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Logic to migrate data will go here.
    // For now, we'll just drop and recreate the table.
    if (oldVersion < newVersion) {
      // Example migration: await db.execute("ALTER TABLE $table ADD COLUMN new_column TEXT;");
    }
  }

  // --- CRUD Operations ---

  // Insert a todo
  Future<int> insert(Todo todo) async {
    Database db = await instance.database;
    return await db.insert(
      table,
      todo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Get all todos
  Future<List<Todo>> getAllTodos() async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(table);

    return List.generate(maps.length, (i) {
      return Todo.fromMap(maps[i]);
    });
  }

  // Update a todo
  Future<int> update(Todo todo) async {
    Database db = await instance.database;
    return await db.update(
      table,
      todo.toMap(),
      where: '$columnId = ?',
      whereArgs: [todo.id],
    );
  }

  // Delete a todo
  Future<int> delete(String id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }
}
