import 'dart:convert';

class TransactionDetail {
  final int id;
  final int transactionId;
  final int productId;
  final double buyingPrice;
  final double sellingPrice;
  final int quantity;
  TransactionDetail({
    required this.id,
    required this.transactionId,
    required this.productId,
    required this.buyingPrice,
    required this.sellingPrice,
    required this.quantity,
  });

  TransactionDetail copyWith({
    int? id,
    int? transactionId,
    int? productId,
    double? buyingPrice,
    double? sellingPrice,
    int? quantity,
  }) {
    return TransactionDetail(
      id: id ?? this.id,
      transactionId: transactionId ?? this.transactionId,
      productId: productId ?? this.productId,
      buyingPrice: buyingPrice ?? this.buyingPrice,
      sellingPrice: sellingPrice ?? this.sellingPrice,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap({int? transactionDetailId}) {
    return {
      'id': id,
      'transactionId': transactionDetailId ?? transactionId,
      'productId': productId,
      'buyingPrice': buyingPrice,
      'sellingPrice': sellingPrice,
      'quantity': quantity,
    };
  }

  factory TransactionDetail.fromMap(Map<String, dynamic> map) {
    return TransactionDetail(
      id: map['id']?.toInt() ?? 0,
      transactionId: map['transactionId']?.toInt() ?? 0,
      productId: map['productId']?.toInt() ?? 0,
      buyingPrice: map['buyingPrice']?.toDouble() ?? 0.0,
      sellingPrice: map['sellingPrice']?.toDouble() ?? 0.0,
      quantity: map['quantity']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory TransactionDetail.fromJson(String source) =>
      TransactionDetail.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TransactionDetail(id: $id, transactionId: $transactionId, productId: $productId, buyingPrice: $buyingPrice, sellingPrice: $sellingPrice, quantity: $quantity)';
  }
}
