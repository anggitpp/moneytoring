import 'package:moneytoring/models/product.dart';
import 'package:sqflite/sqflite.dart';

class ProductRepository {
  final table = 'products';

  Future<void> _createTable() async {
    var db = await openDatabase('moneytoring.db');

    await db.execute('''
    CREATE TABLE $table (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    category_id INTEGER,
    buying_price REAL,
    selling_price REAL,
    stock INTEGER,
    image TEXT,
    status INTEGER)
    ''');
  }

  Future<int> insert(Database db, Product product) async {
    int id = await db.insert(table, product.toJson());

    return id;
  }

  Future<int> update(Database db, Product product) async {
    int id = await db.update(table, product.toJson(),
        where: 'id = ?', whereArgs: [product.id]);

    return id;
  }

  Future<List<Product>> getProducts(Database db) async {
    try {
      await db.query(table, orderBy: 'id DESC');
    } on DatabaseException {
      await _createTable();
    }

    var products = await db.query(table, orderBy: 'id DESC');

    List<Product> productList = products.isNotEmpty
        ? products.map((e) => Product.fromJson(e)).toList()
        : [];

    return productList;
  }

  Future<Product?> getProductById(Database db, int id) async {
    List<Map<String, Object?>> products =
        await db.query(table, where: 'id = ?', whereArgs: [id]);

    if (products.isNotEmpty) {
      return Product.fromJson(products.first);
    }
    return null;
  }

  Future<int> deleteProduct(Database db, int id) async {
    int result = await db.delete(table, where: 'id = ?', whereArgs: [id]);

    return result;
  }
}
