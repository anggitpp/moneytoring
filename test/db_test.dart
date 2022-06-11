import 'package:sqflite/sqflite.dart';

void main() async {
  var db = await openDatabase('my_db.db');

  print(db);
}
