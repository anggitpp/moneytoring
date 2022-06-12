import 'package:moneytoring/models/category.dart';
import 'package:moneytoring/shared/database_helpder.dart';
import 'package:sqflite/sqflite.dart';

class CategoryRepository {
  final table = 'categories';

  Future open(Database db, String path) async {
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          "CREATE TABLE $table (id INTEGER PRIMARY KEY, category_type TEXT, name TEXT, image TEXT)");
    });
  }

  Future<int> insert(Database db, Category category) async {
    int id = await db.insert(table, category.toMap());

    return id;
  }

  Future<List<Category>> getCategories(Database db) async {
    var categories = await db.query(table, orderBy: 'id DESC');

    List<Category> categoryList = categories.isNotEmpty
        ? categories.map((e) => Category.fromMap(e)).toList()
        : [];

    return categoryList;
  }

  Future<Category?> getCategorById(Database db, int id) async {
    List<Map<String, Object?>> categories =
        await db.query(table, where: 'id = ?', whereArgs: [id]);

    if (categories.isNotEmpty) {
      return Category.fromMap(categories.first);
    }
    return null;
  }
}
