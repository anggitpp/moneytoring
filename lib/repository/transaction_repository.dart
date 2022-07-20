import 'dart:convert';

import 'package:moneytoring/models/product.dart';
import 'package:moneytoring/models/transaction_detail.dart';
import 'package:moneytoring/models/transaction_item.dart';
import 'package:moneytoring/models/transaction_model.dart';
import 'package:sqflite/sqflite.dart';

class TransactionRepository {
  final transactionTable = 'transactions';
  final detailTable = 'transaction_details';
  final productTable = 'products';

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
    buying_price REAL,
    selling_price REAL,
    quantity INTEGER, 
    total REAL)
    ''');
  }

  Future<int> insert(Database db, Map<String, dynamic> transactionDatas,
      List<TransactionItem> details) async {
    try {
      int id = await db.insert(transactionTable, transactionDatas);

      for (var detail in details) {
        await db.insert(detailTable, {
          'transaction_id': id,
          'product_id': detail.product.id,
          'buying_price': detail.product.buyingPrice,
          'selling_price': detail.product.sellingPrice,
          'quantity': detail.amount,
          'total': detail.product.sellingPrice * detail.amount
        });
      }

      return id;
    } catch (e) {
      return 1;
    }
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

    //LIST TRANSACTIONS
    var transactions = await db.rawQuery('''
        SELECT *, 
          (SELECT (
            t2.name || '|' || t2.image || '|' || COUNT(t1.id)) as test 
            FROM $detailTable t1 JOIN $productTable t2 ON (t1.product_id = t2.id) 
            WHERE transaction_id = $transactionTable.id LIMIT 1) as detailTransaction 
        FROM $transactionTable''');

    List<TransactionModel> transactionList = transactions.isNotEmpty
        ? transactions.map((e) => TransactionModel.fromJson(e)).toList()
        : [];

    return transactionList;
  }

  Future<List<TransactionDetail>> getTransactionDetails(
      Database db, int transactionId) async {
    List<Map<String, Object?>> detailTransactions = await db.rawQuery(
        "SELECT t1.id, t1.buying_price, t1.selling_price, t1.quantity, t2.category_id, t2.name, t2.image, t2.stock, t2.status FROM $detailTable t1 JOIN $productTable t2 ON t1.product_id = t2.id WHERE t1.transaction_id = '$transactionId'");

    List<TransactionDetail> details = [];
    for (var detail in detailTransactions) {
      details.add(TransactionDetail.convertRowToObject(detail, transactionId));
    }

    return details;
  }
}
