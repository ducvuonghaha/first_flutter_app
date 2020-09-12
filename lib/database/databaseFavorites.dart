import 'dart:async';
import 'package:fruit_flutter/model/favorite_fruits_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBFavorites {
  Database _database;

  Future openDB() async {
    if (_database == null) {
      _database = await openDatabase(
          join(await getDatabasesPath(), "favorites6.db"),
          version: 1, onCreate: (Database db, int version) async {
        await db.execute(
            "CREATE TABLE FAVORITES (idF INTEGER PRIMARY KEY autoincrement, nameF TEXT, descriptionsF TEXT, imageF TEXT)");
      });
    }
  }

  Future<int> insertFavorites(FavoriteFruits favoriteFruits) async {
    await openDB();
    return await _database.insert('favorites', favoriteFruits.toMap());
  }

  Future<List<FavoriteFruits>> getFavorites() async {
    await openDB();
    final List<Map<String, dynamic>> maps = await _database.query('favorites');
    return List.generate(maps.length, (index) {
      return FavoriteFruits(
          idF: maps[index]['idF'],
          nameF: maps[index]['nameF'],
          descriptionsF: maps[index]['descriptionsF'],
          imageF: maps[index]['imageF']);
    });
  }

  Future<int> updateFavorites(FavoriteFruits favoriteFruits) async {
    await openDB();
    return await _database.update('favorites', favoriteFruits.toMap(),
        where: 'idF = ?', whereArgs: [favoriteFruits.idF]);
  }

  Future<void> deleteFavorites(int id) async {
    await openDB();
    await _database.delete('favorites', where: "idF = ?", whereArgs: [id]);
  }
}
