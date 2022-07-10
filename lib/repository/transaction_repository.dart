import 'package:moneytoring/models/category.dart';
import 'package:moneytoring/models/transaction_detail.dart';
import 'package:moneytoring/models/transaction_model.dart';
import 'package:sqflite/sqflite.dart';

class TransactionRepository {
  final transactionTable = 'transactions';
  final detailTable = 'transaction_detail';

  Future open(Database db, String path) async {
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          "CREATE TABLE $transactionTable (id INTEGER PRIMARY KEY, category_type TEXT, buyer_name TEXT, transaction_date DATE, fee REAL, discount REAL, quantity INTEGER, total REAL)");
      await db.execute(
          "CREATE TABLE $detailTable (id INTEGER PRIMARY KEY, transaction_id INTEGER, product_id INTEGER category_type TEXT, buyer_name TEXT, transaction_date DATE, fee REAL, discount REAL, quantity INTEGER, total REAL)");
    });
  }

  Future<int> insert(Database db, TransactionModel transactionModel,
      TransactionDetail transactionDetail) async {
    int id = await db.insert(transactionTable, transactionModel.toMap());
    await db.insert(
        detailTable, transactionDetail.toMap(transactionDetailId: id));

    return id;
  }

  // Future<int> update(Database db, TransactionModel transactionModel,
  //     TransactionDetail transactionDetail) async {
  //   int id = await db.update(transactionTable, transactionModel.toMap(),
  //       where: 'id = ?', whereArgs: [transactionModel.id]);
  //   await db.update(detailTable, transactionDetail.toMap(),
  //       where: 'id = ?', whereArgs: [transactionDetail.id]);

  //   return id;
  // }

  // Future<List<Category>> getCategories(Database db) async {
  //   var categories = await db.query(table, orderBy: 'id DESC');

  //   List<Category> categoryList = categories.isNotEmpty
  //       ? categories.map((e) => Category.fromMap(e)).toList()
  //       : [];

  //   return categoryList;
  // }

  // Future<Category?> getCategoryById(Database db, int id) async {
  //   List<Map<String, Object?>> categories =
  //       await db.query(table, where: 'id = ?', whereArgs: [id]);

  //   if (categories.isNotEmpty) {
  //     return Category.fromMap(categories.first);
  //   }
  //   return null;
  // }

  // Future<int> deleteCategory(Database db, int id) async {
  //   int result = await db.delete(table, where: 'id = ?', whereArgs: [id]);

  //   return result;
  // }
}
