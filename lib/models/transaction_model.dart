import 'dart:convert';

enum TransactionType {
  income,
  expenses,
}

class TransactionModel {
  final int id;
  final TransactionType transactionType;
  final String buyerName;
  final DateTime date;
  final double fee;
  final double discounnt;
  final double totalPrice;
  final int quantity;
  TransactionModel({
    required this.id,
    required this.transactionType,
    required this.buyerName,
    required this.date,
    required this.fee,
    required this.discounnt,
    required this.totalPrice,
    required this.quantity,
  });

  TransactionModel copyWith({
    int? id,
    TransactionType? transactionType,
    String? buyerName,
    DateTime? date,
    double? fee,
    double? discounnt,
    double? totalPrice,
    int? quantity,
  }) {
    return TransactionModel(
      id: id ?? this.id,
      transactionType: transactionType ?? this.transactionType,
      buyerName: buyerName ?? this.buyerName,
      date: date ?? this.date,
      fee: fee ?? this.fee,
      discounnt: discounnt ?? this.discounnt,
      totalPrice: totalPrice ?? this.totalPrice,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'transaction_type':
          transactionType == TransactionType.income ? 'income' : 'expenses',
      'buyerName': buyerName,
      'date': date.millisecondsSinceEpoch,
      'fee': fee,
      'discounnt': discounnt,
      'totalPrice': totalPrice,
      'quantity': quantity,
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id']?.toInt() ?? 0,
      transactionType: map['transaction_type'] == 'income'
          ? TransactionType.income
          : TransactionType.expenses,
      buyerName: map['buyerName'] ?? '',
      date: DateTime.fromMillisecondsSinceEpoch((map['transaction_date'])),
      fee: map['fee']?.toDouble() ?? 0.0,
      discounnt: map['discounnt']?.toDouble() ?? 0.0,
      totalPrice: map['totalPrice']?.toDouble() ?? 0.0,
      quantity: map['quantity']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory TransactionModel.fromJson(String source) =>
      TransactionModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TransactionModel(id: $id, transactionType: $transactionType, buyerName: $buyerName, date: $date, fee: $fee, discounnt: $discounnt, totalPrice: $totalPrice, quantity: $quantity)';
  }
}
