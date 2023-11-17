import 'package:abc_money_diary/repository/sql_database.dart';

import '../models/diary_model.dart';

class SqlDiaryCrudRepository {

  static Future<Diary> create(Diary diary) async {
    var db = await SqlDataBase().database;
    var id = await db.insert(Diary.tableName, diary.toJson());
    return diary.clone(id: id);
  }

  /* 목록 전체 불러오기 */

  // 가계부 목록 전체 불러오기
  static Future<List<Diary>> getList() async {
    var db = await SqlDataBase().database;
    var result = await db.query(
      Diary.tableName,
      columns: [
        DiaryFields.id,
        DiaryFields.money,
        DiaryFields.type,
        DiaryFields.date,
        DiaryFields.time,
        DiaryFields.category,
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

  // A 항목 가계부 목록 전체 불러오기
  static Future<List<Diary>> getListA() async {
    var db = await SqlDataBase().database;
    var result = await db.query(
      Diary.tableName,
      columns: [
        DiaryFields.id,
        DiaryFields.money,
        DiaryFields.type,
        DiaryFields.date,
        DiaryFields.time,
        DiaryFields.category,
        DiaryFields.contents,
        DiaryFields.memo,
      ],
      where: '${DiaryFields.type} = ?',
      whereArgs: ['A'],
      orderBy: DiaryFields.time,
    );

    return result.map(
      (data) {
        return Diary.fromJson(data);
      },
    ).toList();
  }

  // B 항목 가계부 목록 전체 불러오기
  static Future<List<Diary>> getListB() async {
    var db = await SqlDataBase().database;
    var result = await db.query(
      Diary.tableName,
      columns: [
        DiaryFields.id,
        DiaryFields.money,
        DiaryFields.type,
        DiaryFields.date,
        DiaryFields.time,
        DiaryFields.category,
        DiaryFields.contents,
        DiaryFields.memo,
      ],
      where: '${DiaryFields.type} = ?',
      whereArgs: ['B'],
      orderBy: DiaryFields.time,
    );

    return result.map(
          (data) {
        return Diary.fromJson(data);
      },
    ).toList();
  }

  // C 항목 가계부 목록 전체 불러오기
  static Future<List<Diary>> getListC() async {
    var db = await SqlDataBase().database;
    var result = await db.query(
      Diary.tableName,
      columns: [
        DiaryFields.id,
        DiaryFields.money,
        DiaryFields.type,
        DiaryFields.date,
        DiaryFields.time,
        DiaryFields.category,
        DiaryFields.contents,
        DiaryFields.memo,
      ],
      where: '${DiaryFields.type} = ?',
      whereArgs: ['C'],
      orderBy: DiaryFields.time,
    );

    return result.map(
          (data) {
        return Diary.fromJson(data);
      },
    ).toList();
  }



  /* 한 달치 목록 불러오기 */

  // 한 달치 가계부 불러오기
  static Future<List<Diary>> getMonthList(String month) async {
    var db = await SqlDataBase().database;
    var result = await db.rawQuery(
        "SELECT * FROM ${Diary.tableName} WHERE ${DiaryFields.date} >= date('$month','start of month','localtime') "
            "AND ${DiaryFields.date} <= date('$month','start of month','+1 month','-1 day','localtime')"
            "ORDER BY ${DiaryFields.time} ;",
        null
    );

    return result.map(
          (data) {
        return Diary.fromJson(data);
      },
    ).toList();
  }

  // A 한 달치 가계부 불러오기
  static Future<List<Diary>> getMonthListA(String month) async {
    var db = await SqlDataBase().database;
    var result = await db.rawQuery(
        "SELECT * FROM ${Diary.tableName} WHERE ${DiaryFields.date} >= date('$month','start of month','localtime') "
            "AND ${DiaryFields.date} <= date('$month','start of month','+1 month','-1 day','localtime') AND ${DiaryFields.type} = 'A'"
            "ORDER BY ${DiaryFields.time} ;",
        null
    );

    return result.map(
          (data) {
        return Diary.fromJson(data);
      },
    ).toList();
  }

  // B 한 달치 가계부 불러오기
  static Future<List<Diary>> getMonthListB(String month) async {
    var db = await SqlDataBase().database;
    var result = await db.rawQuery(
        "SELECT * FROM ${Diary.tableName} WHERE ${DiaryFields.date} >= date('$month','start of month','localtime') "
            "AND ${DiaryFields.date} <= date('$month','start of month','+1 month','-1 day','localtime') AND ${DiaryFields.type} = 'B'"
            "ORDER BY ${DiaryFields.time} ;",
        null
    );

    return result.map(
          (data) {
        return Diary.fromJson(data);
      },
    ).toList();
  }

  // C 한 달치 가계부 불러오기
  static Future<List<Diary>> getMonthListC(String month) async {
    var db = await SqlDataBase().database;
    var result = await db.rawQuery(
        "SELECT * FROM ${Diary.tableName} WHERE ${DiaryFields.date} >= date('$month','start of month','localtime') "
            "AND ${DiaryFields.date} <= date('$month','start of month','+1 month','-1 day','localtime') AND ${DiaryFields.type} = 'C'"
            "ORDER BY ${DiaryFields.time} ;",
        null
    );

    return result.map(
          (data) {
        return Diary.fromJson(data);
      },
    ).toList();
  }

  /* 하루치 목록 불러오기 */

  // 하루치 가계부 불러오기
  static Future<List<Diary>> getDayList(String date) async {
    var db = await SqlDataBase().database;
    var result = await db.rawQuery(
        "SELECT * FROM ${Diary.tableName} WHERE ${DiaryFields.date} >= date('$date', 'localtime') "
            " AND ${DiaryFields.date} <= date('$date', 'localtime', '+1 days') ORDER BY ${DiaryFields.time} ;",
        null
    );

    return result.map(
          (data) {
        return Diary.fromJson(data);
      },
    ).toList();
  }


  /* 총 합 불러오기 */

  // A 총합 불러오기
  static Future<String> getTotalMoneyA(String month) async {
    var db = await SqlDataBase().database;
    var results = await db.rawQuery(
        "SELECT SUM(${DiaryFields.money}) FROM ${Diary.tableName} WHERE ${DiaryFields.date} >= date('$month','start of month','localtime') "
            "AND ${DiaryFields.date} <= date('$month','start of month','+1 month','-1 day','localtime') AND ${DiaryFields.type} = 'A' ");

    String str = results.toString();

    if(str.contains('null')) {
      return '0';
    }

    return resultToCleanString(str);
  }

  // B 총합 불러오기
  static Future<String> getTotalMoneyB(String month) async {
    var db = await SqlDataBase().database;
    var results = await db.rawQuery(
        "SELECT SUM(${DiaryFields.money}) as sum FROM ${Diary.tableName} WHERE ${DiaryFields.date} >= date('$month','start of month','localtime') "
            "AND ${DiaryFields.date} <= date('$month','start of month','+1 month','-1 day','localtime') AND ${DiaryFields.type} = 'B' ");

    String str = results.toString();

    if(str.contains('null')) {
      return '0';
    }

    return resultToCleanString(str);
  }

  // C 총합 불러오기
  static Future<String> getTotalMoneyC(String month) async {
    var db = await SqlDataBase().database;
    var results = await db.rawQuery(
        "SELECT SUM(${DiaryFields.money}) as sum FROM ${Diary.tableName} WHERE ${DiaryFields.date} >= date('$month','start of month','localtime') "
            "AND ${DiaryFields.date} <= date('$month','start of month','+1 month','-1 day','localtime') AND ${DiaryFields.type} = 'C' ");

    String str = results.toString();

    if(str.contains('null')) {
      return '0';
    }

    return resultToCleanString(str);
  }




  /* 선택이나 수정, 삭제 등 */

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

  //가계부 수정
  static Future<int> update(Diary diary) async {
    var db = await SqlDataBase().database;
    return await db.update(
      Diary.tableName,
      diary.toJson(),
      where: '${DiaryFields.id}=?',
      whereArgs: [diary.id],
    );
  }

  //가계부 삭제
  static Future<int> delete(int id) async {
    var db = await SqlDataBase().database;
    return await db.delete(
      Diary.tableName,
      where: '${DiaryFields.id}=?',
      whereArgs: [id],
    );
  }

  //가계부 전체 삭제
  static Future<int> deleteAll() async {
    var db = await SqlDataBase().database;
    return await db.delete(
      Diary.tableName,
    );
  }




  //돈 깔끔하게 숫자만 있게 만드는 거
  static String resultToCleanString(String str){
    List num = ['0','1','2','3','4','5','6','7','8','9'];
    int firstIndex=0;
    int lastIndex=0;
    var temp = str.split('');

    for(int i=0;i<str.length;i++){
      if(num.contains(temp[i])) {
        firstIndex = i;
        break;
      }
    }

    for(int i=0;i<str.length;i++){
      if(temp[i]=='.' || temp[i]=='}') {
        lastIndex = i;
        break;
      }
    }

    String result = str.substring(firstIndex, lastIndex);
    return result;
  }
}
