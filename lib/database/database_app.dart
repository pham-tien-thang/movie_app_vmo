
import 'package:movie_app_vmo/model/movie_liked.dart';
import 'package:movie_app_vmo/model/user_model.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';
class DatabaseMovie {
  static const String TABLE_USER = "USER";
  static const String USER_NAME = "USER_NAME";
  static  String USER_AVATAR = "USER_AVATAR";
  static const String USER_PASSWORD = "USER_PASSWWORD";
  static const String USER_PHONE = "USER_PHONE";
  static const String USER_MAIL = "USER_MAIL";
  //
  static const String LIKE_TABLE = "LIKE";
  static const String OWNER = "USER_NAME";
  static  String ID_VIDEO = "USER_AVATAR";
  Database? _database;
  Future openDb() async {
    if (_database == null) {
      _database = await openDatabase(
          join(await getDatabasesPath(), "database_movie.db"),
          version: 1, onCreate: (Database db, int version) async {
        await db.execute(
          "CREATE TABLE $TABLE_USER($USER_NAME TEXT PRIMARY KEY,$USER_AVATAR TEXT,"
              "$USER_PASSWORD TEXT,$USER_PHONE INTEGER,$USER_MAIL TEXT)",
        );
        await db.execute(
          "CREATE TABLE $LIKE_TABLE($OWNER TEXT, $ID_VIDEO INTEGER)",
        );
      });
    }
  }
  Future closeDb() async {
    if (_database!.isOpen) {
    _database!.close();
    }
  }
//them nguoi dung
  Future<int> insertUser(User user) async {
    await openDb();
    return await _database!.insert(TABLE_USER, user.toMap());
  }
  //sua nguoi dung
  Future<void> updateUser(User user) async {
    await openDb();
   var a = await _database!.update(
      TABLE_USER,
      user.toMap(),
      where: '$USER_NAME = ?',
      whereArgs: [user.userName],
    );
  }
  //like video
  Future<int> insertLike(MovieLiked movieLiked) async {
    await openDb();
    return await _database!.insert(LIKE_TABLE, movieLiked.toMap());
  }
  //xoa nguoi dung
  Future<void> deleteUser(String name) async {
    await openDb();
    await _database!.delete(
      TABLE_USER,
      where: "$USER_NAME = ?", whereArgs: [name],
    );
  }
  // lay danh sach nguoi dung
  Future<List<User>> getAlluser() async {
    await openDb();
    final List<Map<String, dynamic>> maps = await _database!.query(TABLE_USER);
    return List.generate(maps.length, (i) {
      return User(
          userName : maps[i][USER_NAME],
          userAvatar: maps[i][USER_AVATAR],
          userMail: maps[i][USER_MAIL],
          userPassword: maps[i][USER_PASSWORD]as String,
          userPhone: maps[i][USER_PHONE],
      );
    });
  }

//check
  Future<List<User>> getUserByNameAndPassWord(String name,String pass) async {
    await openDb();
    final List<Map<String, dynamic>> maps = await _database!.query(TABLE_USER,where: "$USER_NAME=? and $USER_PASSWORD=?",
        whereArgs: [name,pass]);
    return List.generate(maps.length, (i) {
      return User(
        userName : maps[i][USER_NAME]??"",
        userAvatar: maps[i][USER_AVATAR]??"",
        userMail: maps[i][USER_MAIL]??"",
        userPassword: maps[i][USER_PASSWORD]??0 as String,
        userPhone: maps[i][USER_PHONE]??0 as String,
      );
    });
  }
  Future<List<User>> getUserByName(String name) async {
    await openDb();
    final List<Map<String, dynamic>> maps = await _database!.query(TABLE_USER,where: "$USER_NAME=?",whereArgs: [name]);
    return List.generate(maps.length, (i) {
      return User(
        userName : maps[i][USER_NAME],
        userAvatar: maps[i][USER_AVATAR],
        userMail: maps[i][USER_MAIL],
        userPassword: maps[i][USER_PASSWORD],
        userPhone: maps[i][USER_PHONE],
      );
    });
  }
//   Future<List<product>> getName() async {
//     await openDb();
//     final List<Map<String, dynamic>> maps = await _database.query(TABLE_NAME);
//     return List.generate(maps.length, (i) {
//       return product(
//           id : maps[i][COL_ID], name: maps[i][COL_NAME], url: maps[i][COL_URL],description: maps[i][COL_DES]);
//     });
//   }

//   //bảng cart
//   Future<int> insertCart(cart_model p) async {
//     await openDb();
//     return await _database.insert(TABLE_CART, p.toMap());
//   }
//   Future<List<cart_model>> getCart() async {
//     await openDb();
//     final List<Map<String, dynamic>> maps = await _database.query(TABLE_CART);
//     return List.generate(maps.length, (i) {
//       return cart_model(
//           id_c : maps[i][COL_ID_C], name_c: maps[i][COL_NAME_C], url_c: maps[i][COL_URL_C],description_c: maps[i][COL_DES_C]);
//     });
//   }
//   Future<void> deleteCart(int t) async {
//     await openDb();
//     await _database.delete(
//       TABLE_CART,
//       where: "$COL_ID_C = ?", whereArgs: [t],
//     );
//   }
// //bang user
//   Future<int> insertUser(user_model us) async {
//     await openDb();
//     return await _database.insert(TABLE_USER, us.toMap());
//   }
//
//   Future<List<user_model>> getuserbyname(String us,String pw) async {
//     await openDb();
//     final List<Map<String, dynamic>> maps = await _database. query( TABLE_USER,
//       where: "$COL_USER = ?", whereArgs: [us],);
//     return List.generate(maps.length, (i) {
//       return user_model(
//           username : maps[i][COL_USER], pw: maps[i][COL_PW]);
//     });
//   }

//   Future<void> deleteus(String t) async {
//     await openDb();
//     await _database.delete(
//       TABLE_USER,
//       where: "$COL_USER = ?", whereArgs: [t],
//     );
//   }
}