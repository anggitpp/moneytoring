part of 'transaction_cubit.dart';

enum TransactionRecapStatus {
  initial,
  loading,
  loaded,
  error,
}

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
  loading,
  loaded,
  submitting,
  finish,
  error,
}

class TransactionState extends Equatable {
  final TransactionCategoryStatus transactionCategoryStatus;
  final TransactionProductStatus transactionProductStatus;
  final TransactionModel? transaction;
  final List<Category> categories;
  final List<Product> products;
  final List<TransactionItem> transactionItems;
  final List<TransactionModel> transactions;
  final Category? selectedCategory;
  final double totalPrice;
  final TransactionStatus transactionStatus;
  final int totalProfit;
  final int totalIncome;
  final int totalExpenses;
  final TransactionRecapStatus transactionRecapStatus;
  final List<TopProductSales> topSales;
  final List<TopProductCategory> topCategories;
  const TransactionState({
    required this.transactionCategoryStatus,
    required this.transactionProductStatus,
    this.transaction,
    required this.categories,
    required this.products,
    required this.transactionItems,
    required this.transactions,
    this.selectedCategory,
    required this.totalPrice,
    required this.transactionStatus,
    this.totalProfit = 0,
    this.totalIncome = 0,
    this.totalExpenses = 0,
    required this.transactionRecapStatus,
    required this.topSales,
    required this.topCategories,
  });

  factory TransactionState.initial() {
    return const TransactionState(
      transactionCategoryStatus: TransactionCategoryStatus.initial,
      transactionProductStatus: TransactionProductStatus.initial,
      transactionStatus: TransactionStatus.initial,
      transactionRecapStatus: TransactionRecapStatus.initial,
      categories: [],
      transactions: [],
      products: [],
      transactionItems: [],
      totalPrice: 0,
      topSales: [],
      topCategories: [],
    );
  }

  TransactionState copyWith({
    TransactionCategoryStatus? transactionCategoryStatus,
    TransactionProductStatus? transactionProductStatus,
    TransactionModel? transaction,
    List<Category>? categories,
    List<Product>? products,
    List<TransactionItem>? transactionItems,
    List<TransactionModel>? transactions,
    Category? selectedCategory,
    double? totalPrice,
    TransactionStatus? transactionStatus,
    int? totalProfit,
    int? totalIncome,
    int? totalExpenses,
    TransactionRecapStatus? transactionRecapStatus,
    List<TopProductSales>? topSales,
    List<TopProductCategory>? topCategories,
  }) {
    return TransactionState(
      transactionCategoryStatus:
          transactionCategoryStatus ?? this.transactionCategoryStatus,
      transactionProductStatus:
          transactionProductStatus ?? this.transactionProductStatus,
      transaction: transaction ?? this.transaction,
      categories: categories ?? this.categories,
      products: products ?? this.products,
      transactionItems: transactionItems ?? this.transactionItems,
      transactions: transactions ?? this.transactions,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      totalPrice: totalPrice ?? this.totalPrice,
      transactionStatus: transactionStatus ?? this.transactionStatus,
      totalProfit: totalProfit ?? this.totalProfit,
      totalIncome: totalIncome ?? this.totalIncome,
      totalExpenses: totalExpenses ?? this.totalExpenses,
      transactionRecapStatus:
          transactionRecapStatus ?? this.transactionRecapStatus,
      topSales: topSales ?? this.topSales,
      topCategories: topCategories ?? this.topCategories,
    );
  }

  @override
  String toString() {
    return 'TransactionState(transactionCategoryStatus: $transactionCategoryStatus, transactionProductStatus: $transactionProductStatus, transaction: $transaction, categories: $categories, products: $products, transactionItems: $transactionItems, transactions: $transactions, selectedCategory: $selectedCategory, totalPrice: $totalPrice, transactionStatus: $transactionStatus, totalProfit: $totalProfit, totalIncome: $totalIncome, totalExpenses: $totalExpenses, transactionRecapStatus: $transactionRecapStatus, topSales: $topSales, topCategories: $topCategories)';
  }

  @override
  List<Object> get props {
    return [
      transactionCategoryStatus,
      transactionProductStatus,
      transaction ?? '',
      categories,
      products,
      transactionItems,
      transactions,
      selectedCategory ?? '',
      totalPrice,
      transactionStatus,
      totalProfit,
      totalIncome,
      totalExpenses,
      transactionRecapStatus,
      topSales,
      topCategories,
    ];
  }
}
