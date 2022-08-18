import 'package:moneytoring/models/category.dart';
import 'package:sqflite/sqflite.dart';

class CategoryRepository {
  final table = 'categories';

  Future<int> insert(Database db, Category category) async {
    int id = await db.insert(table, category.toMap());

    return id;
  }

  Future<int> update(Database db, Category category) async {
    int id = await db.update(table, category.toMap(),
        where: 'id = ?', whereArgs: [category.id]);

    return id;
  }

  Future<List<Category>> getCategories(Database db) async {
    var categories = await db.query(table, orderBy: 'id DESC');

    List<Category> categoryList = categories.isNotEmpty
        ? categories.map((e) => Category.fromMap(e)).toList()
        : [];

    return categoryList;
  }

  Future<Category?> getCategoryById(Database db, int id) async {
    List<Map<String, Object?>> categories =
        await db.query(table, where: 'id = ?', whereArgs: [id]);

    if (categories.isNotEmpty) {
      return Category.fromMap(categories.first);
    }
    return null;
  }

  Future<int> deleteCategory(Database db, int id) async {
    int result = await db.delete(table, where: 'id = ?', whereArgs: [id]);

    return result;
  }
}
