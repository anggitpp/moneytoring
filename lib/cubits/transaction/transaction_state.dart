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

class TransactionState extends Equatable {
  final TransactionCategoryStatus transactionCategoryStatus;
  final TransactionProductStatus transactionProductStatus;
  final List<Category> categories;
  final List<Product> products;
  final List<TransactionItem> transactionItems;
  final Category? selectedCategory;
  const TransactionState({
    required this.transactionCategoryStatus,
    required this.transactionProductStatus,
    required this.categories,
    required this.products,
    required this.transactionItems,
    this.selectedCategory,
  });

  factory TransactionState.initial() {
    return const TransactionState(
      transactionCategoryStatus: TransactionCategoryStatus.initial,
      transactionProductStatus: TransactionProductStatus.initial,
      categories: [],
      products: [],
      transactionItems: [],
    );
  }

  TransactionState copyWith({
    TransactionCategoryStatus? transactionCategoryStatus,
    TransactionProductStatus? transactionProductStatus,
    List<Category>? categories,
    List<Product>? products,
    List<TransactionItem>? transactionItems,
    Category? selectedCategory,
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
    );
  }

  @override
  String toString() {
    return 'TransactionState(transactionCategoryStatus: $transactionCategoryStatus, transactionProductStatus: $transactionProductStatus, categories: $categories, products: $products, transactionItems: $transactionItems, selectedCategory: $selectedCategory)';
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
    ];
  }
}
