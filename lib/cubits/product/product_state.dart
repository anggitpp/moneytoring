part of 'product_cubit.dart';

enum AddProductStatus {
  initial,
  loading,
  success,
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
  final List<Category> categories;
  //TODO :: CHECK IF THIS IS NEEDED
  final String imagePath;
  final bool isLoadedImage;
  const ProductState({
    required this.addProductStatus,
    required this.productCategoryStatus,
    required this.categories,
    required this.imagePath,
    required this.isLoadedImage,
  });

  factory ProductState.initial() {
    return const ProductState(
        addProductStatus: AddProductStatus.initial,
        productCategoryStatus: ProductCategoryStatus.initial,
        categories: [],
        isLoadedImage: false,
        imagePath: '');
  }

  ProductState copyWith({
    AddProductStatus? addProductStatus,
    ProductCategoryStatus? productCategoryStatus,
    List<Category>? categories,
    String? imagePath,
    bool? isLoadedImage,
  }) {
    return ProductState(
      addProductStatus: addProductStatus ?? this.addProductStatus,
      productCategoryStatus:
          productCategoryStatus ?? this.productCategoryStatus,
      categories: categories ?? this.categories,
      imagePath: imagePath ?? this.imagePath,
      isLoadedImage: isLoadedImage ?? this.isLoadedImage,
    );
  }

  @override
  String toString() {
    return 'ProductState(addProductStatus: $addProductStatus, productCategoryStatus: $productCategoryStatus, categories: $categories, imagePath: $imagePath, isLoadedImage: $isLoadedImage)';
  }

  @override
  List<Object> get props {
    return [
      addProductStatus,
      productCategoryStatus,
      categories,
      imagePath,
      isLoadedImage,
    ];
  }
}
