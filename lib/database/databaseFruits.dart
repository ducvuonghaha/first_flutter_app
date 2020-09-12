import 'package:fruit_flutter/model/fruits_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class DbFruitsManager {
  Database _database;

  Future openDB() async {
    if (_database == null) {
      _database = await openDatabase(
          join(await getDatabasesPath(), "fruits12.db") ,
          version: 1, onCreate: (Database db, int version) async {
        await db.execute(
            "CREATE TABLE FRUITS (id INTEGER PRIMARY KEY autoincrement, name TEXT, descriptions TEXT, image TEXT)");
      });
    }
  }

  Future<int> insertFruit(Fruits fruits) async {
    await openDB();
    return await _database.insert('fruits', fruits.toMap());
  }

  Future<List<Fruits>> getFruitList() async {
    await openDB();
    final List<Map<String, dynamic>> maps = await _database.query('fruits');
    return List.generate(maps.length, (index) {
      return Fruits(
          id: maps[index]['id'],
          name: maps[index]['name'],
          descriptions: maps[index]['descriptions'],
          image: maps[index]['image']);
    });
  }

  Future<int> updateFruit(Fruits fruits) async {
    await openDB();
    return await _database.update('fruits', fruits.toMap(),
        where: "id = ?", whereArgs: [fruits.id]);
  }

  Future<void> deleteFruit(int id) async {
    await openDB();
    await _database.delete('fruits', where: "id = ?", whereArgs: [id]);
  }
}
