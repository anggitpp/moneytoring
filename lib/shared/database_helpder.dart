import 'dart:io';

import 'package:moneytoring/models/category.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../config/constant.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    String path = join(documentsDirectory.path, databaseApplication);

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE categories (id INTEGER PRIMARY KEY AUTOINCREMENT, category_type TEXT, name TEXT, image TEXT)');
    await db.transaction(
      (db) async {
        await db.insert(
          'categories',
          const Category(
                  categoryType: CategoryType.income,
                  name: 'Aquarium Kaca',
                  imagePath: 'assets/icon/icon-aquarium.png')
              .toMap(),
        );
        await db.insert(
          'categories',
          const Category(
                  categoryType: CategoryType.income,
                  name: 'Smart Device',
                  imagePath: 'assets/icon/icon-bulb.png')
              .toMap(),
        );
        await db.insert(
          'categories',
          const Category(
                  categoryType: CategoryType.income,
                  name: 'Electronic',
                  imagePath: 'assets/icon/icon-electronic.png')
              .toMap(),
        );
        await db.insert(
          'categories',
          const Category(
                  categoryType: CategoryType.expenses,
                  name: 'Aquarium Kaca',
                  imagePath: 'assets/icon/icon-aquarium.png')
              .toMap(),
        );
        await db.insert(
          'categories',
          const Category(
                  categoryType: CategoryType.expenses,
                  name: 'Smart Device',
                  imagePath: 'assets/icon/icon-bulb.png')
              .toMap(),
        );
        await db.insert(
          'categories',
          const Category(
                  categoryType: CategoryType.expenses,
                  name: 'Electronic',
                  imagePath: 'assets/icon/icon-electronic.png')
              .toMap(),
        );

        await db.insert(
          'categories',
          const Category(
                  categoryType: CategoryType.expenses,
                  name: 'Aquarium Kaca',
                  imagePath: 'assets/icon/icon-aquarium.png')
              .toMap(),
        );
      },
    );
  }
}
