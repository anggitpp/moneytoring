import 'dart:convert';

import 'package:moneytoring/models/product.dart';

class TransactionItem {
  final int id;
  final Product product;
  final int amount;
  TransactionItem({
    required this.id,
    required this.product,
    required this.amount,
  });

  TransactionItem copyWith({
    int? id,
    Product? product,
    int? amount,
  }) {
    return TransactionItem(
      id: id ?? this.id,
      product: product ?? this.product,
      amount: amount ?? this.amount,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'product': product.toMap(),
      'amount': amount,
    };
  }

  factory TransactionItem.fromMap(Map<String, dynamic> map) {
    return TransactionItem(
      id: map['id']?.toInt() ?? 0,
      product: Product.fromMap(map['product']),
      amount: map['amount']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory TransactionItem.fromJson(String source) =>
      TransactionItem.fromMap(json.decode(source));

  @override
  String toString() =>
      'TransactionItem(id: $id, product: $product, amount: $amount)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TransactionItem &&
        other.id == id &&
        other.product == product &&
        other.amount == amount;
  }

  @override
  int get hashCode => id.hashCode ^ product.hashCode ^ amount.hashCode;
}
