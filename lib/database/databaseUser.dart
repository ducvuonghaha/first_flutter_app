import 'package:fruit_flutter/model/user_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class DBUsers {
  Database _database;

  Future openDB() async {
    if (_database == null) {
      _database = await openDatabase(
          join(await getDatabasesPath(), 'users5.db'),
          version: 1, onCreate: (Database db, int version) async {
        await db.execute(
            "CREATE TABLE USERS (idU INTEGER PRIMARY KEY autoincrement, usernameU TEXT, passwordU TEXT, fullnameU TEXT, phoneU TEXT, emailU TEXT)");
      });
    }
  }

  Future<int> insertUser(Users users) async {
    await openDB();
    return await _database.insert('users', users.toMap());
  }

  Future<int> updateUser(Users users) async {
    await openDB();
    return await _database.update('users', users.toMap(),
        where: "idU = ?", whereArgs: [users.id]);
  }

  Future<void> deleteUser(int id) async {
    await openDB();
    return await _database.delete('users', where: "idU = ?", whereArgs: [id]);
  }

  Future<List<Users>> getUsers() async {
    await openDB();
    final List<Map<String, dynamic>> maps = await _database.query('users');
    return List.generate(maps.length, (index) {
      return Users(
          id: maps[index]['idU'],
          username: maps[index]['usernameU'],
          password: maps[index]['passwordU'],
          fullname: maps[index]['fullnameU'],
          email: maps[index]['emailU'],
          phone: maps[index]['phoneU']);
    });
  }

  Future<List<Users>> getUserbyName(String name) async {
    await openDB();
    final List<Map<String, dynamic>> maps =
        await _database.query('users WHERE usernameU = ' + '"' + name + '"');
    return List.generate(maps.length, (index) {
      return Users(
          id: maps[index]['idU'],
          username: maps[index]['usernameU'],
          password: maps[index]['passwordU'],
          fullname: maps[index]['fullnameU'],
          email: maps[index]['emailU'],
          phone: maps[index]['phoneU']);
    });
  }
}
