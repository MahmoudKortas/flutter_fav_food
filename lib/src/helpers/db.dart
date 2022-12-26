import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_fav_food/src/models/dish.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MyDb {
  late Database db;

  Future open() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'fooddd.db');
    //join is from path package
    if (kDebugMode) {
      print(path);
    } //output /data/user/0/com.testapp.flutter.testapp/databases/food.db

    db = await openDatabase(path, version: 2,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table students/users

      await db.execute('''
                    CREATE TABLE IF NOT EXISTS users( 
                          id INTEGER primary key   AUTOINCREMENT,
                          login varchar(255) not null,
                          password varchar(255) not null,
                          permission varchar(255) not null
                      ); 
                  ''');
      await db.execute(''' 
                    CREATE TABLE IF NOT EXISTS food( 
                          id INTEGER primary key AUTOINCREMENT,
                          name varchar(255) not null,
                          description varchar(255) not null,
                          img_path varchar(255) not null
                      ); 
                  ''');
      await db.execute(''' 
                    CREATE TABLE IF NOT EXISTS fav( 
                          id INTEGER primary key AUTOINCREMENT,
                          user_id INTEGER NOT NULL,
                          food_id INTEGER NOT NULL,
                          FOREIGN KEY (user_id) REFERENCES users (id) 
                ON DELETE NO ACTION ON UPDATE NO ACTION,
              FOREIGN KEY (food_id) REFERENCES food (id) 
                ON DELETE NO ACTION ON UPDATE NO ACTION
                      ); 
                  ''');
      //table students will be created if there is no table 'students'
      log("Tables Created");
    });
  }

  Future<void> deleteDatabase(String path) =>
      databaseFactory.deleteDatabase(path);

  Future getUsers() async {
    List<Map> maps = await db.query('users');
    //getting student data with roll no.
    log("Users::$maps");
  }

  Future<List<Dish>> getDishs() async {
    List<Map<String, Object?>> maps = await db.query('food');
    //getting student data with roll no.
    // log("foods::$maps");
    List<Dish> model = maps.map((e) => Dish.fromJson(e)).toList();

    return model;
  }
  Future<List<Dish>> getFav() async {
    List<Map<String, Object?>> maps = await db.query('fav');
    //getting student data with roll no.
     log("fav::$maps");
    List<Dish> model = maps.map((e) => Dish.fromJson(e)).toList();

    return model;
  }

  Future<Map<dynamic, dynamic>?> getUser(int id) async {
    List<Map> maps = await db.query('users', where: 'id = ?', whereArgs: [id]);
    //getting student data with roll no.
    if (maps.isNotEmpty) {
      return maps.first;
    }
    return null;
  }

  Future<Map<dynamic, dynamic>?> getFood(int id) async {
    List<Map> maps = await db.query('food', where: 'id = ?', whereArgs: [id]);
    //getting student data with roll no.
    if (maps.isNotEmpty) {
      return maps.first;
    }
    return null;
  }
  /*Future<Map<dynamic, dynamic>?> getStudent(int rollno) async {
    List<Map> maps = await db.query('students',
        where: 'roll_no = ?',
        whereArgs: [rollno]);
    //getting student data with roll no.
    if (maps.length > 0) {
       return maps.first;
    }
    return null;
  }*/
}
