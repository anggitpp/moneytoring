import 'dart:convert';

import 'category.dart';

class TransactionModel {
  final int id;
  final CategoryType categoryType;
  final String buyerName;
  final String transactionDate;
  final double fee;
  final double discount;
  final double totalPrice;
  final int quantity;
  final String detailTransaction;
  TransactionModel({
    required this.id,
    required this.categoryType,
    required this.buyerName,
    required this.transactionDate,
    required this.fee,
    required this.discount,
    required this.totalPrice,
    required this.quantity,
    required this.detailTransaction,
  });

  TransactionModel copyWith({
    int? id,
    CategoryType? categoryType,
    String? buyerName,
    String? transactionDate,
    double? fee,
    double? discount,
    double? totalPrice,
    int? quantity,
    String? detailTransaction,
  }) {
    return TransactionModel(
      id: id ?? this.id,
      categoryType: categoryType ?? this.categoryType,
      buyerName: buyerName ?? this.buyerName,
      transactionDate: transactionDate ?? this.transactionDate,
      fee: fee ?? this.fee,
      discount: discount ?? this.discount,
      totalPrice: totalPrice ?? this.totalPrice,
      quantity: quantity ?? this.quantity,
      detailTransaction: detailTransaction ?? this.detailTransaction,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category_type':
          categoryType == CategoryType.income ? 'income' : 'expenses',
      'buyer_name': buyerName,
      'transaction_date': transactionDate,
      'fee': fee,
      'discount': discount,
      'total': totalPrice,
      'quantity': quantity,
      'detailTransaction': detailTransaction,
    };
  }

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id']?.toInt() ?? 0,
      categoryType: json['category_type'] == 'income'
          ? CategoryType.income
          : CategoryType.expenses,
      buyerName: json['buyer_name'] ?? '',
      transactionDate: json['transaction_date'] ?? '',
      fee: json['fee']?.toDouble() ?? 0.0,
      discount: json['discount']?.toDouble() ?? 0.0,
      totalPrice: json['total']?.toDouble() ?? 0.0,
      quantity: json['quantity']?.toInt() ?? 0,
      detailTransaction: json['detailTransaction'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  // factory TransactionModel.fromJson(String source) =>
  //     TransactionModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TransactionModel(id: $id, categoryType: $categoryType, buyer_name: $buyerName, transaction_date: $transactionDate, fee: $fee, discount: $discount, total: $totalPrice, quantity: $quantity, detailTransaction: $detailTransaction)';
  }
}
