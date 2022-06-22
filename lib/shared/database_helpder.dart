import 'package:moneytoring/config/constant.dart';
import 'package:moneytoring/models/category.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async =>
      _database ??= await initializeDatabase();

  Future<Database> initializeDatabase() async {
    //Get the directory path for both Android and IOS to store Database
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, databaseApplication);
    //Open/create the database at the given path
    var wifiSystemDatabase =
        await openDatabase(path, version: 1, onCreate: _onCreate);
    return wifiSystemDatabase;
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
                  imagePath: 'assets/category/icon-aquarium.png')
              .toMap(),
        );
        await db.insert(
          'categories',
          const Category(
                  categoryType: CategoryType.income,
                  name: 'Smart Device',
                  imagePath: 'assets/category/icon-bulb.png')
              .toMap(),
        );
        await db.insert(
          'categories',
          const Category(
                  categoryType: CategoryType.income,
                  name: 'Electronic',
                  imagePath: 'assets/category/icon-electronic.png')
              .toMap(),
        );
        await db.insert(
          'categories',
          const Category(
                  categoryType: CategoryType.expenses,
                  name: 'Aquarium Kaca',
                  imagePath: 'assets/category/icon-aquarium.png')
              .toMap(),
        );
        await db.insert(
          'categories',
          const Category(
                  categoryType: CategoryType.expenses,
                  name: 'Smart Device',
                  imagePath: 'assets/category/icon-bulb.png')
              .toMap(),
        );
        await db.insert(
          'categories',
          const Category(
                  categoryType: CategoryType.expenses,
                  name: 'Electronic',
                  imagePath: 'assets/category/icon-electronic.png')
              .toMap(),
        );
      },
    );
  }
}
