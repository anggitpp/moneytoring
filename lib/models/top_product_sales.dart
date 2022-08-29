import 'dart:convert';

class TopProductSales {
  final String productName;
  final String imagePath;
  final int productId;
  final int totalQuantity;
  final double sellingPrice;
  TopProductSales({
    required this.productName,
    required this.imagePath,
    required this.productId,
    required this.totalQuantity,
    required this.sellingPrice,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': productName,
      'image': imagePath,
      'product_id': productId,
      'totalQuantity': totalQuantity,
      'selling_price': sellingPrice,
    };
  }

  factory TopProductSales.fromMap(Map<String, dynamic> map) {
    return TopProductSales(
      productName: map['name'] ?? '',
      imagePath: map['image'] ?? '',
      productId: map['product_id']?.toInt() ?? 0,
      totalQuantity: map['totalQuantity']?.toInt() ?? 0,
      sellingPrice: map['selling_price'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory TopProductSales.fromJson(String source) =>
      TopProductSales.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TopProductSales(productName: $productName, imagePath: $imagePath, productId: $productId, totalQuantity: $totalQuantity, sellingPrice: $sellingPrice)';
  }
}
