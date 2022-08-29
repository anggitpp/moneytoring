import 'package:moneytoring/models/top_product_category.dart';
import 'package:moneytoring/models/top_product_sales.dart';
import 'package:moneytoring/models/transaction_detail.dart';
import 'package:moneytoring/models/transaction_item.dart';
import 'package:moneytoring/models/transaction_model.dart';
import 'package:sqflite/sqflite.dart';

class TransactionRepository {
  final transactionTable = 'transactions';
  final detailTable = 'transaction_details';
  final productTable = 'products';
  final categoryTable = 'categories';

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

        await db.update(
          productTable,
          {'stock': detail.product.stock - detail.amount},
          where: 'id = ?',
          whereArgs: [detail.product.id],
        );
      }

      return id;
    } catch (e) {
      return 1;
    }
  }

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

  Future<List<TopProductSales>> getTopProductSales(Database db) async {
    try {
      await db.query(detailTable, orderBy: 'id DESC');
    } on DatabaseException {
      await _createTable();
    }

    var result = await db.rawQuery(
        '''SELECT SUM(t1.quantity) totalQuantity, product_id, category_type, t3.name, t3.image, t3.selling_price 
        FROM $detailTable t1 JOIN $transactionTable t2 ON t1.transaction_id = t2.id 
        JOIN $productTable t3 ON t1.product_id = t3.id 
        WHERE t2.category_type = 'income'
        GROUP BY product_id ORDER BY totalQuantity DESC LIMIT 5''');
    List<TopProductSales> datas = result.isNotEmpty
        ? result.map((e) => TopProductSales.fromMap(e)).toList()
        : [];

    return datas;
  }

  Future<List<TopProductCategory>> getTopCategorySales(Database db) async {
    try {
      await db.query(detailTable, orderBy: 'id DESC');
    } on DatabaseException {
      await _createTable();
    }

    var result = await db.rawQuery(
        '''SELECT SUM(t1.quantity) totalQuantity, t3.category_id, t4.name 
        FROM $detailTable t1 JOIN $transactionTable t2 ON t1.transaction_id = t2.id 
        JOIN $productTable t3 ON t1.product_id = t3.id 
        JOIN $categoryTable t4 ON t3.category_id = t4.id 
        WHERE t2.category_type = 'income'
        GROUP BY category_id ORDER BY totalQuantity DESC LIMIT 5''');

    List<TopProductCategory> datas = result.isNotEmpty
        ? result.map((e) => TopProductCategory.fromMap(e)).toList()
        : [];

    return datas;
  }

  Future<List<TransactionDetail>> getTransactionDetails(
      Database db, int transactionId) async {
    List<Map<String, Object?>> detailTransactions = await db.rawQuery(
        "SELECT t1.id, t1.buying_price, t1.selling_price, t1.quantity, t2.id as productId, t2.category_id, t2.name, t2.image, t2.stock, t2.status FROM $detailTable t1 JOIN $productTable t2 ON t1.product_id = t2.id WHERE t1.transaction_id = '$transactionId'");

    List<TransactionDetail> details = [];
    for (var detail in detailTransactions) {
      details.add(TransactionDetail.convertRowToObject(detail, transactionId));
    }

    return details;
  }

  Future<int> update(Database db, Map<String, dynamic> transactionDatas,
      List<TransactionItem> details, int transactionId) async {
    try {
      int id = await db.update(transactionTable, transactionDatas,
          where: 'id = ?', whereArgs: [transactionId]);

      await db.delete(detailTable,
          where: 'transaction_id = ?', whereArgs: [transactionId]);
      for (var detail in details) {
        await db.insert(
          detailTable,
          {
            'transaction_id': transactionId,
            'product_id': detail.product.id,
            'buying_price': detail.product.buyingPrice,
            'selling_price': detail.product.sellingPrice,
            'quantity': detail.amount,
            'total': detail.product.sellingPrice * detail.amount
          },
        );

        await db.update(
          productTable,
          {'stock': detail.product.stock - detail.amount},
          where: 'id = ?',
          whereArgs: [detail.product.id],
        );
      }

      return id;
    } catch (e) {
      return 0;
    }
  }

  Future<void> delete(Database db, int transactionId) async {
    try {
      await db.delete(transactionTable,
          where: 'id = ?', whereArgs: [transactionId]);

      List<Map<String, Object?>> details = await db.query(detailTable,
          where: 'transaction_id = ?', whereArgs: [transactionId]);

      //LIST DETAILS
      for (var detail in details) {
        //GET PRODUCT STOCK FROM SELECTED ITEM
        var getProduct = await db.query(productTable,
            where: 'id = ?', whereArgs: [detail['product_id']]);
        int stock = int.parse(getProduct[0]['stock'].toString());

        //UPDATE STOCK
        await db.update(
          productTable,
          {'stock': stock + int.parse(detail['quantity'].toString())},
          where: 'id = ?',
          whereArgs: [detail['product_id']],
        );
      }

      //DELETE ALL TRANSACTION DETAIL AFTER UPDATE STOCK
      await db.delete(detailTable,
          where: 'transaction_id = ?', whereArgs: [transactionId]);
    } catch (e) {
      rethrow;
    }
  }
}
