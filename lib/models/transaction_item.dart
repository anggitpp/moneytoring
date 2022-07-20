import 'dart:convert';

import 'package:moneytoring/models/product.dart';

class TransactionItem {
  final int id;
  final Product product;
  final double sellingPrice;
  final int amount;
  TransactionItem({
    required this.id,
    required this.product,
    required this.sellingPrice,
    required this.amount,
  });

  TransactionItem copyWith({
    int? id,
    Product? product,
    double? sellingPrice,
    int? amount,
  }) {
    return TransactionItem(
      id: id ?? this.id,
      product: product ?? this.product,
      sellingPrice: sellingPrice ?? this.sellingPrice,
      amount: amount ?? this.amount,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'product': product.toJson(),
      'sellingPrice': sellingPrice,
      'amount': amount,
    };
  }

  factory TransactionItem.fromMap(Map<String, dynamic> map) {
    return TransactionItem(
      id: map['id']?.toInt() ?? 0,
      product: Product.fromJson(map['product']),
      sellingPrice: map['sellingPrice']?.toDouble() ?? 0.0,
      amount: map['amount']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory TransactionItem.fromJson(String source) =>
      TransactionItem.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TransactionItem(id: $id, product: $product, sellingPrice: $sellingPrice, amount: $amount)';
  }
}
