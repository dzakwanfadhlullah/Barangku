import 'package:sqflite/sqflite.dart';
import '../../../../core/database/app_database.dart';
import 'models/user_model.dart';

class AuthRepository {
  final Future<Database> _dbFuture = AppDatabase.instance.database;

  Future<void> registerUser(UserModel user) async {
    final db = await _dbFuture;
    await db.insert('users', user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.abort);
  }

  Future<UserModel?> authenticateUser(String username, String password) async {
    final db = await _dbFuture;
    final maps = await db.query(
      'users',
      where: 'username = ? AND password = ?',
      whereArgs: [username, password],
    );

    if (maps.isNotEmpty) {
      return UserModel.fromMap(maps.first);
    }
    return null;
  }

  Future<UserModel?> getUserByUsername(String username) async {
    final db = await _dbFuture;
    final maps = await db.query(
      'users',
      where: 'username = ?',
      whereArgs: [username],
    );

    if (maps.isNotEmpty) {
      return UserModel.fromMap(maps.first);
    }
    return null;
  }

  Future<bool> verifySecurityAnswer(String username, String answer) async {
    final db = await _dbFuture;
    final maps = await db.query(
      'users',
      columns: ['security_answer'],
      where: 'username = ?',
      whereArgs: [username],
    );

    if (maps.isNotEmpty) {
      final dbAnswer = maps.first['security_answer'] as String;
      // Case insensitive match
      return dbAnswer.toLowerCase() == answer.toLowerCase();
    }
    return false;
  }

  Future<void> updatePassword(String username, String newPassword) async {
    final db = await _dbFuture;
    await db.update(
      'users',
      {'password': newPassword},
      where: 'username = ?',
      whereArgs: [username],
    );
  }
}
