part of 'transaction_cubit.dart';

enum TransactionCategoryStatus {
  initial,
  loading,
  loaded,
  error,
}

class TransactionState extends Equatable {
  final TransactionCategoryStatus transactionCategoryStatus;
  final List<Category> categories;
  final Category? selectedCategory;
  const TransactionState({
    required this.transactionCategoryStatus,
    required this.categories,
    this.selectedCategory,
  });

  factory TransactionState.initial() {
    return const TransactionState(
        transactionCategoryStatus: TransactionCategoryStatus.initial,
        categories: []);
  }

  TransactionState copyWith({
    TransactionCategoryStatus? transactionCategoryStatus,
    List<Category>? categories,
    Category? selectedCategory,
  }) {
    return TransactionState(
      transactionCategoryStatus:
          transactionCategoryStatus ?? this.transactionCategoryStatus,
      categories: categories ?? this.categories,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }

  @override
  String toString() =>
      'TransactionState(transactionCategoryStatus: $transactionCategoryStatus, categories: $categories, selectedCategory: $selectedCategory)';

  @override
  List<Object> get props =>
      [transactionCategoryStatus, categories, selectedCategory ?? ''];
}
