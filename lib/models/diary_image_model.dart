import 'dart:typed_data';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const String picTableName = 'Pics';

class Picture {
  int? id;
  int diaryID;
  Uint8List picture;

  Picture({this.id, required this.diaryID, required this.picture});

  Map<String, dynamic> toMap(){
    return {
      "id": id,
      "diaryID": diaryID,
      "picture" : picture,
    };
  }
}

class PicProvider {
  late Database _database;

  Future<Database?> get database async {
    _database = await initDB();
    return _database;
  }

  initDB() async {
    String path = join(await getDatabasesPath(), 'Pics.db');

    return await openDatabase(
        path,
        version: 1,
        onCreate: (db, version) async {
          await db.execute('''
            CREATE TABLE Pics(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              diaryID INTEGER NOT NULL,
              picture BLOB NOT NULL
            )
          ''');
        },
        onUpgrade: (db, oldVersion, newVersion){}
    );
  }

  Future<void> insert(Picture pic) async {
    final db = await database;
    print("Pics insert ${pic.diaryID}");
    pic.id = await db?.insert(picTableName, pic.toMap());
  }

  Future<void> delete(Picture pic) async {
    final db = await database;
    print("Pics delete ${pic.diaryID}");
    await db?.delete(
      picTableName,
      where: "id = ?",
      whereArgs: [pic.id],
    );
  }

  Future<void> deleteSpec(int diaryID) async {
    final db = await database;
    print("Pics delete all ${diaryID}");
    await db?.delete(
      picTableName,
      where: "specID = ?",
      whereArgs: [diaryID],
    );
  }

  Future<List<Picture>> getDB() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db!.query(picTableName);
    if( maps.isEmpty ) return [];
    List<Picture> list = List.generate(maps.length, (index) {
      return Picture(
        id: maps[index]["id"],
        diaryID: maps[index]["specID"],
        picture: maps[index]["picture"],
      );
    });
    return list;
  }

  Future<List<Picture>> getQuery(String query) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db!.rawQuery(query);
    if( maps.isEmpty ) return [];
    List<Picture> list = List.generate(maps.length, (index) {
      return Picture(
        id: maps[index]["id"],
        diaryID: maps[index]["specID"],
        picture: maps[index]["picture"],
      );
    });
    return list;
  }

}
