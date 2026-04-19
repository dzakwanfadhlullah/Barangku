import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  static final AppDatabase instance = AppDatabase._init();

  static Database? _database;

  AppDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('barangku.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    const idType = 'TEXT PRIMARY KEY';
    const textType = 'TEXT NOT NULL';
    const textNullable = 'TEXT';
    const intType = 'INTEGER NOT NULL';
    const realType = 'REAL NOT NULL';

    // Tabel Users
    await db.execute('''
CREATE TABLE users (
  id $idType,
  name $textType,
  username $textType UNIQUE,
  password $textType,
  security_question $textType,
  security_answer $textType
)
''');

    // Tabel Items
    await db.execute('''
CREATE TABLE items (
  id $idType,
  name $textType,
  sku $textNullable,
  category $textNullable,
  initial_stock $intType,
  unit $textNullable,
  price $realType,
  description $textNullable,
  status_stock $textNullable,
  created_at $textType
)
''');
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
