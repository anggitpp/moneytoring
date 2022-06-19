part of 'product_cubit.dart';

enum AddProductStatus {
  initial,
  loading,
  success,
  error,
}

enum ProductStatus {
  initial,
  loading,
  loaded,
  error,
}

enum ProductCategoryStatus {
  initial,
  loading,
  loaded,
  error,
}

class ProductState extends Equatable {
  final AddProductStatus addProductStatus;
  final ProductCategoryStatus productCategoryStatus;
  final ProductStatus productStatus;
  final List<Category> categories;
  final List<Product> products;
  //TODO :: CHECK IF THIS IS NEEDED
  final String imagePath;
  final bool isLoadedImage;
  const ProductState({
    required this.addProductStatus,
    required this.productCategoryStatus,
    required this.productStatus,
    required this.categories,
    required this.products,
    required this.imagePath,
    required this.isLoadedImage,
  });

  factory ProductState.initial() {
    return const ProductState(
        addProductStatus: AddProductStatus.initial,
        productCategoryStatus: ProductCategoryStatus.initial,
        productStatus: ProductStatus.initial,
        categories: [],
        products: [],
        isLoadedImage: false,
        imagePath: '');
  }

  ProductState copyWith({
    AddProductStatus? addProductStatus,
    ProductCategoryStatus? productCategoryStatus,
    ProductStatus? productStatus,
    List<Category>? categories,
    List<Product>? products,
    String? imagePath,
    bool? isLoadedImage,
  }) {
    return ProductState(
      addProductStatus: addProductStatus ?? this.addProductStatus,
      productCategoryStatus:
          productCategoryStatus ?? this.productCategoryStatus,
      productStatus: productStatus ?? this.productStatus,
      categories: categories ?? this.categories,
      products: products ?? this.products,
      imagePath: imagePath ?? this.imagePath,
      isLoadedImage: isLoadedImage ?? this.isLoadedImage,
    );
  }

  @override
  String toString() {
    return 'ProductState(addProductStatus: $addProductStatus, productCategoryStatus: $productCategoryStatus, productStatus: $productStatus, categories: $categories, products: $products, imagePath: $imagePath, isLoadedImage: $isLoadedImage)';
  }

  @override
  List<Object> get props {
    return [
      addProductStatus,
      productCategoryStatus,
      productStatus,
      categories,
      products,
      imagePath,
      isLoadedImage,
    ];
  }
}
