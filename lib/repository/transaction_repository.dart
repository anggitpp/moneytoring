import 'package:moneytoring/models/category.dart';
import 'package:moneytoring/models/transaction_detail.dart';
import 'package:moneytoring/models/transaction_model.dart';
import 'package:sqflite/sqflite.dart';

class TransactionRepository {
  final transactionTable = 'transactions';
  final detailTable = 'transaction_details';

  // Future open(Database db, String path) async {
  //   db = await openDatabase(path, version: 1,
  //       onCreate: (Database db, int version) async {
  //     await db.execute(
  //         "CREATE TABLE $transactionTable (id INTEGER PRIMARY KEY, category_type TEXT, buyer_name TEXT, transaction_date DATE, fee REAL, discount REAL, quantity INTEGER, total REAL)");
  //     await db.execute(
  //         "CREATE TABLE $detailTable (id INTEGER PRIMARY KEY, transaction_id INTEGER, product_id INTEGER category_type TEXT, buyer_name TEXT, transaction_date DATE, fee REAL, discount REAL, quantity INTEGER, total REAL)");
  //   });
  // }

  Future<void> _createTable() async {
    var db = await openDatabase('moneytoring.db');

    await db.execute('''
    CREATE TABLE $transactionTable (
    id INTEGER PRIMARY KEY AUTOINCREMENT, 
    category_type TEXT, 
    buyer_name TEXT, 
    transaction_date DATE, 
    fee REAL, 
    discount REAL, 
    quantity INTEGER, 
    total REAL)
    ''');

    await db.execute('''
    CREATE TABLE $detailTable (
    id INTEGER PRIMARY KEY AUTOINCREMENT, 
    transaction_id INTEGER, 
    product_id INTEGER, 
    category_type TEXT, 
    quantity INTEGER, 
    total REAL)
    ''');
  }

  Future<int> insert(Database db, Map<String, dynamic> transactionDatas) async {
    int id = await db.insert(transactionTable, transactionDatas);

    print(id);

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

  Future<List<TransactionModel>> getTransactions(Database db) async {
    // db.rawQuery("DROP TABLE IF EXISTS $transactionTable");
    // db.rawQuery("DROP TABLE IF EXISTS $detailTable");

    try {
      await db.query(transactionTable, orderBy: 'id DESC');
    } on DatabaseException {
      await _createTable();
    }

    var transactions = await db.query(transactionTable, orderBy: 'id DESC');

    List<TransactionModel> transactionList = transactions.isNotEmpty
        ? transactions.map((e) => TransactionModel.fromMap(e)).toList()
        : [];

    return transactionList;
  }

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
