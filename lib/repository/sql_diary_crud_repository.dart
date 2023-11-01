import 'package:abc_money_diary/repository/sql_database.dart';

import '../models/diary_model.dart';

class SqlDiaryCrudRepository {

  static Future<Diary> create(Diary diary) async {
    var db = await SqlDataBase().database;
    var id = await db.insert(Diary.tableName, diary.toJson());
    return diary.clone(id: id);
  }

  //가계부 목록 전체 불러오기
  static Future<List<Diary>> getList() async {
    var db = await SqlDataBase().database;
    var result = await db.query(
      Diary.tableName,
      columns: [
        DiaryFields.id,
        DiaryFields.type,
        DiaryFields.date,
        DiaryFields.time,
        DiaryFields.category,
        DiaryFields.money,
        DiaryFields.contents,
        DiaryFields.memo,
      ],
      orderBy: DiaryFields.time,
    );

    return result.map(
      (data) {
        return Diary.fromJson(data);
      },
    ).toList();
  }

  //한 달치 가계부 불러오기
  static Future<List<Diary>> getMonthList() async {
    var db = await SqlDataBase().database;
    var result = await db.rawQuery(
        "SELECT * FROM ${Diary.tableName} WHERE ${DiaryFields.date} >= date('now','start of month','localtime') "
            "AND ${DiaryFields.date} <= date('now','start of month','+1 month','-1 day','localtime') ORDER BY ${DiaryFields.time} ;",
        null
    );

    return result.map(
          (data) {
        return Diary.fromJson(data);
      },
    ).toList();
  }

  //가계부 한 개를 선택해서 불러오기
  static Future<Diary?> getDiaryOne(int id) async {
    var db = await SqlDataBase().database;
    var result = await db.query(
      Diary.tableName,
      columns: [
        DiaryFields.category,
        DiaryFields.contents,
        DiaryFields.date,
        DiaryFields.id,
        DiaryFields.memo,
        DiaryFields.money,
        DiaryFields.time,
        DiaryFields.type,
      ],
      where: '${DiaryFields.id} = ?',
      whereArgs: [id],
    );

    var list = result.map(
      (data) {
        return Diary.fromJson(data);
      },
    ).toList();
    if (list.isNotEmpty) {
      return list.first;
    } else {
      return null;
    }
  }
  
  static Future<int> update(Diary diary) async {
    var db = await SqlDataBase().database;
    return await db.update(
      Diary.tableName,
      diary.toJson(),
      where: '${DiaryFields.id}=?',
      whereArgs: [diary.id],
    );
  }

  static Future<int> delete(int id) async {
    var db = await SqlDataBase().database;
    return await db.delete(
      Diary.tableName,
      where: '${DiaryFields.id}=?',
      whereArgs: [id],
    );
  }

  static Future<int> deleteAll() async {
    var db = await SqlDataBase().database;
    return await db.delete(
      Diary.tableName,
    );
  }


}
