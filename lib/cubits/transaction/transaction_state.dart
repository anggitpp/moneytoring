part of 'transaction_cubit.dart';

enum TransactionCategoryStatus {
  initial,
  loading,
  loaded,
  error,
}

enum TransactionProductStatus {
  initial,
  loading,
  loaded,
  error,
}

enum TransactionStatus {
  initial,
  submitting,
  finish,
  error,
}

class TransactionState extends Equatable {
  final TransactionCategoryStatus transactionCategoryStatus;
  final TransactionProductStatus transactionProductStatus;
  final List<Category> categories;
  final List<Product> products;
  final List<TransactionItem> transactionItems;
  final Category? selectedCategory;
  final double totalPrice;
  final TransactionStatus transactionStatus;
  const TransactionState({
    required this.transactionCategoryStatus,
    required this.transactionProductStatus,
    required this.categories,
    required this.products,
    required this.transactionItems,
    this.selectedCategory,
    required this.totalPrice,
    required this.transactionStatus,
  });

  factory TransactionState.initial() {
    return const TransactionState(
      transactionCategoryStatus: TransactionCategoryStatus.initial,
      transactionProductStatus: TransactionProductStatus.initial,
      transactionStatus: TransactionStatus.initial,
      categories: [],
      products: [],
      transactionItems: [],
      totalPrice: 0,
    );
  }

  TransactionState copyWith({
    TransactionCategoryStatus? transactionCategoryStatus,
    TransactionProductStatus? transactionProductStatus,
    List<Category>? categories,
    List<Product>? products,
    List<TransactionItem>? transactionItems,
    Category? selectedCategory,
    double? totalPrice,
    TransactionStatus? transactionStatus,
  }) {
    return TransactionState(
      transactionCategoryStatus:
          transactionCategoryStatus ?? this.transactionCategoryStatus,
      transactionProductStatus:
          transactionProductStatus ?? this.transactionProductStatus,
      categories: categories ?? this.categories,
      products: products ?? this.products,
      transactionItems: transactionItems ?? this.transactionItems,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      totalPrice: totalPrice ?? this.totalPrice,
      transactionStatus: transactionStatus ?? this.transactionStatus,
    );
  }

  @override
  String toString() {
    return 'TransactionState(transactionCategoryStatus: $transactionCategoryStatus, transactionProductStatus: $transactionProductStatus, categories: $categories, products: $products, transactionItems: $transactionItems, selectedCategory: $selectedCategory, totalPrice: $totalPrice, transactionStatus: $transactionStatus)';
  }

  @override
  List<Object> get props {
    return [
      transactionCategoryStatus,
      transactionProductStatus,
      categories,
      products,
      transactionItems,
      selectedCategory ?? '',
      totalPrice,
      transactionStatus,
    ];
  }
}
