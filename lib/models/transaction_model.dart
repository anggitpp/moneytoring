import 'dart:convert';

enum TransactionType {
  income,
  expenses,
}

class TransactionModel {
  final int id;
  final TransactionType transactionType;
  final String buyerName;
  final String transactionDate;
  final double fee;
  final double discount;
  final double totalPrice;
  final int quantity;
  final String detailTransaction;
  TransactionModel({
    required this.id,
    required this.transactionType,
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
    TransactionType? transactionType,
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
      transactionType: transactionType ?? this.transactionType,
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
      'transaction_type':
          transactionType == TransactionType.income ? 'income' : 'expenses',
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
      transactionType: json['transaction_type'] == 'income'
          ? TransactionType.income
          : TransactionType.expenses,
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
    return 'TransactionModel(id: $id, transactionType: $transactionType, buyer_name: $buyerName, transaction_date: $transactionDate, fee: $fee, discount: $discount, total: $totalPrice, quantity: $quantity, detailTransaction: $detailTransaction)';
  }
}
