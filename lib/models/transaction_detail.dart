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
            id: detail['productId'],
            name: detail['name'].toString(),
            categoryId: int.parse(detail['category_id'].toString()),
            buyingPrice: double.parse(detail['buying_price'].toString()),
            sellingPrice: double.parse(detail['selling_price'].toString()),
            stock: int.parse(detail['stock'].toString()),
            imagePath: detail['image'].toString(),
            status: int.parse(detail['status'].toString())),
        quantity: detail['quantity'].toString());
  }

  @override
  String toString() {
    return 'TransactionDetail(id: $id, transactionId: $transactionId, product: $product, quantity: $quantity)';
  }
}
