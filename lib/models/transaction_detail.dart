import 'product.dart';

class TransactionDetail {
  TransactionDetail({
    required this.id,
    required this.transactionId,
    required this.product,
    required this.quantity,
  });

  int id;
  int transactionId;
  Product product;
  String quantity;

  factory TransactionDetail.fromJson(Map<String, dynamic> json) =>
      TransactionDetail(
        id: json["id"],
        transactionId: json["transaction_id"],
        product: Product.fromJson(json["product"]),
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "transactionId": transactionId,
        "product": product.toJson(),
        "quantity": quantity,
      };

  factory TransactionDetail.convertRowToObject(detail, transactionId) {
    return TransactionDetail(
        id: int.parse(detail['id'].toString()),
        transactionId: transactionId,
        product: Product(
            name: detail['name'].toString(),
            categoryId: int.parse(detail['category_id'].toString()),
            buyingPrice: double.parse(detail['buying_price'].toString()),
            sellingPrice: double.parse(detail['selling_price'].toString()),
            stock: int.parse(detail['stock'].toString()),
            imagePath: detail['image'].toString(),
            status: int.parse(detail['status'].toString())),
        quantity: detail['quantity'].toString());
  }
}



// import 'dart:convert';

// import 'product.dart';

// class TransactionDetail {
//   final int id;
//   final int transactionId;
//   final Product product;
//   final int quantity;
//   TransactionDetail({
//     required this.id,
//     required this.transactionId,
//     required this.product,
//     required this.quantity,
//   });

//   TransactionDetail copyWith({
//     int? id,
//     int? transactionId,
//     Product? product,
//     int? quantity,
//   }) {
//     return TransactionDetail(
//       id: id ?? this.id,
//       transactionId: transactionId ?? this.transactionId,
//       product: product ?? this.product,
//       quantity: quantity ?? this.quantity,
//     );
//   }

//   factory TransactionDetail.fromMap(Map<String, dynamic> map) {
//     return TransactionDetail(
//       id: map['id']?.toInt() ?? 0,
//       transactionId: map['transactionId']?.toInt() ?? 0,
//       product: Product.fromMap(map['product']),
//       quantity: map['quantity']?.toInt() ?? 0,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory TransactionDetail.fromJson(String source) =>
//       TransactionDetail.fromMap(json.decode(source));

//   @override
//   String toString() {
//     return 'TransactionDetail(id: $id, transactionId: $transactionId, product: $product, quantity: $quantity)';
//   }

//   Map<String, dynamic> toMap({int? transactionDetailId}) {
//     return {
//       'id': id,
//       'transactionId': transactionDetailId ?? transactionId,
//       'product': product.toMap(),
//       'quantity': quantity,
//     };
//   }
// }
