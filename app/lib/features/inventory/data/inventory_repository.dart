import 'package:sqflite/sqflite.dart';
import '../../../../core/database/app_database.dart';
import 'models/item_model.dart';

class InventoryRepository {
  final Future<Database> _dbFuture = AppDatabase.instance.database;

  Future<void> insertItem(ItemModel item) async {
    final db = await _dbFuture;
    await db.insert(
      'items',
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<ItemModel>> getAllItems() async {
    final db = await _dbFuture;
    final maps = await db.query(
      'items',
      orderBy: 'created_at DESC',
    );
    return maps.map((map) => ItemModel.fromMap(map)).toList();
  }

  Future<void> updateItem(ItemModel item) async {
    final db = await _dbFuture;
    await db.update(
      'items',
      item.toMap(),
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }

  Future<void> deleteItem(String id) async {
    final db = await _dbFuture;
    await db.delete(
      'items',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
