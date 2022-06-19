import 'package:moneytoring/models/product.dart';
import 'package:sqflite/sqflite.dart';

class ProductCategory {
  final table = 'products';

  Future open(Database db, String path) async {
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
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
    });
  }

  Future<int> insert(Database db, Product product) async {
    int id = await db.insert(table, product.toMap());

    return id;
  }

  Future<int> update(Database db, Product product) async {
    int id = await db.update(table, product.toMap(),
        where: 'id = ?', whereArgs: [product.id]);

    return id;
  }

  Future<List<Product>> getProducts(Database db) async {
    var products = await db.query(table, orderBy: 'id DESC');

    List<Product> productList = products.isNotEmpty
        ? products.map((e) => Product.fromMap(e)).toList()
        : [];

    return productList;
  }

  Future<Product?> getProductById(Database db, int id) async {
    List<Map<String, Object?>> products =
        await db.query(table, where: 'id = ?', whereArgs: [id]);

    if (products.isNotEmpty) {
      return Product.fromMap(products.first);
    }
    return null;
  }

  Future<int> deleteProduct(Database db, int id) async {
    int result = await db.delete(table, where: 'id = ?', whereArgs: [id]);

    return result;
  }
}
