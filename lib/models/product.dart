class Product {
  Product({
    this.id,
    required this.name,
    required this.categoryId,
    required this.buyingPrice,
    required this.sellingPrice,
    required this.stock,
    required this.imagePath,
    required this.status,
  });

  int? id;
  String name;
  int categoryId;
  double buyingPrice;
  double sellingPrice;
  int stock;
  String imagePath;
  int status;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        categoryId: json["category_id"],
        buyingPrice: json["buying_price"],
        sellingPrice: json["selling_price"],
        stock: json["stock"],
        imagePath: json["image"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "category_id": categoryId,
        "buying_price": buyingPrice,
        "selling_price": sellingPrice,
        "stock": stock,
        "image": imagePath,
        "status": status,
      };

  @override
  String toString() {
    return 'Product(id: $id, name: $name, categoryId: $categoryId, buyingPrice: $buyingPrice, sellingPrice: $sellingPrice, stock: $stock, imagePath: $imagePath, status: $status)';
  }
}


// class Product {
//   final int? id;
//   final String name;
//   final int categoryId;
//   final double buyingPrice;
//   final double sellingPrice;
//   final int stock;
//   final String imagePath;
//   final int status;
//   Product({
//     this.id,
//     required this.name,
//     required this.categoryId,
//     required this.buyingPrice,
//     required this.sellingPrice,
//     required this.stock,
//     required this.imagePath,
//     required this.status,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'name': name,
//       'category_id': categoryId,
//       'buying_price': buyingPrice,
//       'selling_price': sellingPrice,
//       'stock': stock,
//       'image': imagePath,
//       'status': status,
//     };
//   }

//   factory Product.fromMap(Map<String, dynamic> map) => Product(
//         id: map['id'],
//         name: map['name'],
//         categoryId: map['category_id'],
//         buyingPrice: map['buying_price'],
//         sellingPrice: map['selling_price'],
//         stock: map['stock'],
//         imagePath: map['image'],
//         status: map['status'],
//       );

  
// }
