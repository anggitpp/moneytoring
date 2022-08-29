import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:moneytoring/models/top_product_category.dart';
import 'package:moneytoring/models/top_product_sales.dart';
import 'package:moneytoring/models/transaction_model.dart';
import 'package:sqflite/sqflite.dart';

import 'package:moneytoring/models/product.dart';
import 'package:moneytoring/models/transaction_item.dart';
import 'package:moneytoring/repository/repositories.dart';

import '../../config/constant.dart';
import '../../models/category.dart';
import '../../models/transaction_detail.dart';

part 'transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  TransactionCubit({
    required this.categoryRepository,
    required this.productRepository,
    required this.transactionRepository,
  }) : super(TransactionState.initial());

  final CategoryRepository categoryRepository;
  final ProductRepository productRepository;
  final TransactionRepository transactionRepository;

  Future<List<Category>> loadCategories() async {
    emit(state.copyWith(
        transactionCategoryStatus: TransactionCategoryStatus.loading));
    var db = await openDatabase('moneytoring.db');

    List<Category> categories = await categoryRepository.getCategories(db);

    emit(state.copyWith(
        transactionCategoryStatus: TransactionCategoryStatus.loaded,
        categories: categories));

    return categories;
  }

  void loadProducts() async {
    emit(state.copyWith(
        transactionProductStatus: TransactionProductStatus.loading));

    var db = await openDatabase('moneytoring.db');

    List<Product> products = await productRepository.getProducts(db);

    emit(
      state.copyWith(
          transactionProductStatus: TransactionProductStatus.loaded,
          products: products),
    );
  }

  void loadTransactions() async {
    emit(state.copyWith(transactionStatus: TransactionStatus.loading));

    var db = await openDatabase('moneytoring.db');

    List<TransactionModel> transactions =
        await transactionRepository.getTransactions(db);

    int totalIncome = 0;
    int totalExpenses = 0;
    int totalProfit = 0;

    var incomeTransactions = transactions
        .where((element) => element.categoryType == CategoryType.income);
    var expenseTransactions = transactions
        .where((element) => element.categoryType == CategoryType.expenses);
    if (incomeTransactions.isNotEmpty) {
      totalIncome = transactions
          .where((element) => element.categoryType == CategoryType.income)
          .map((e) => e.totalPrice)
          .reduce((a, b) => a + b)
          .toInt();
    }
    if (expenseTransactions.isNotEmpty) {
      totalExpenses = transactions
          .where((element) => element.categoryType == CategoryType.expenses)
          .map((e) => e.totalPrice)
          .reduce((a, b) => a + b)
          .toInt();
    }
    totalProfit = totalIncome - totalExpenses;

    emit(
      state.copyWith(
          transactionStatus: TransactionStatus.loaded,
          transactions: transactions,
          totalIncome: totalIncome,
          totalExpenses: totalExpenses,
          totalProfit: totalProfit),
    );
  }

  void onPressCategory(Category category) {
    emit(state.copyWith(selectedCategory: category));
  }

  void onPressProduct(TransactionItem transactionItem) {
    var contain = state.transactionItems
        .where((element) => element.product.id == transactionItem.product.id);

    if (contain.isEmpty) {
      emit(state.copyWith(
          transactionItems: [...state.transactionItems, transactionItem]));
    } else {
      final items = [
        for (final item in state.transactionItems)
          if (item == contain.first)
            item.copyWith(
                amount: item.product.stock == item.amount
                    ? item.amount
                    : item.amount + 1)
          else
            item
      ];

      emit(
        state.copyWith(transactionItems: items),
      );
    }
  }

  void onPressAddTransactionItem(TransactionItem transactionItem) {
    var contain = state.transactionItems
        .where((element) => element.product == transactionItem.product);
    final items = [
      for (final item in state.transactionItems)
        if (item == contain.first)
          item.copyWith(
              amount: item.product.stock == item.amount
                  ? item.amount
                  : item.amount + 1)
        else
          item
    ];

    emit(
      state.copyWith(transactionItems: items),
    );
  }

  void onPressRemoveTransactionItem(TransactionItem transactionItem) {
    var contain = state.transactionItems
        .where((element) => element.product == transactionItem.product);
    if (transactionItem.amount == 1) {
      final items = state.transactionItems
          .where((element) => element != transactionItem)
          .toList();

      emit(
        state.copyWith(transactionItems: items),
      );
    } else {
      final items = [
        for (final item in state.transactionItems)
          if (item == contain.first)
            item.copyWith(amount: item.amount - 1)
          else
            item
      ];

      emit(
        state.copyWith(transactionItems: items),
      );
    }
  }

  void getTotalPrice(String discount, String fee) {
    var totalPrice = state.transactionItems
        .map((element) => element.product.sellingPrice * element.amount)
        .reduce((a, b) => a + b);

    if (discount == '') {
      discount = '0';
    }

    if (fee == '') {
      fee = '0';
    }

    totalPrice -= num.parse(discount);
    totalPrice -= num.parse(fee);

    emit(state.copyWith(totalPrice: totalPrice));
  }

  void insertTransaction(Map<String, dynamic> transactionData,
      List<TransactionItem> detailDatas) async {
    var db = await openDatabase(databaseApplication);

    emit(state.copyWith(transactionStatus: TransactionStatus.submitting));

    try {
      await transactionRepository.insert(db, transactionData, detailDatas);

      List<TransactionModel> transactions =
          await transactionRepository.getTransactions(db);

      emit(state.copyWith(
        transactionStatus: TransactionStatus.finish,
        transactions: transactions,
      ));
    } catch (e) {
      emit(state.copyWith(transactionStatus: TransactionStatus.error));
    }
  }

  void getTransactionDetails(TransactionModel transaction) async {
    emit(state.copyWith(
        transactionProductStatus: TransactionProductStatus.loading));
    var db = await openDatabase(databaseApplication);
    List<TransactionDetail> details =
        await transactionRepository.getTransactionDetails(db, transaction.id);

    List<TransactionItem> items = [
      for (final detail in details)
        TransactionItem(
            id: detail.id,
            product: detail.product,
            amount: int.parse(detail.quantity),
            sellingPrice: detail.product.sellingPrice)
    ];

    emit(state.copyWith(
        transactionProductStatus: TransactionProductStatus.loaded,
        transactionItems: items,
        transaction: transaction));
  }

  void updateTransaction(Map<String, dynamic> transactionData,
      List<TransactionItem> detailDatas, int transactionId) async {
    var db = await openDatabase(databaseApplication);

    emit(state.copyWith(transactionStatus: TransactionStatus.submitting));

    try {
      await transactionRepository.update(
          db, transactionData, detailDatas, transactionId);

      List<TransactionModel> transactions =
          await transactionRepository.getTransactions(db);

      emit(state.copyWith(
          transactionStatus: TransactionStatus.finish,
          transactions: transactions));
    } catch (e) {
      emit(state.copyWith(transactionStatus: TransactionStatus.error));
    }
  }

  void getRecapTransaction() async {
    var db = await openDatabase(databaseApplication);

    emit(
        state.copyWith(transactionRecapStatus: TransactionRecapStatus.loading));

    try {
      print('test');

      List<TopProductSales> datas =
          await transactionRepository.getTopProductSales(db);

      print(datas);

      List<TopProductCategory> categories =
          await transactionRepository.getTopCategorySales(db);

      emit(state.copyWith(
          transactionRecapStatus: TransactionRecapStatus.loaded,
          topCategories: categories,
          topSales: datas));
    } catch (e) {
      emit(
          state.copyWith(transactionRecapStatus: TransactionRecapStatus.error));
    }
  }

  void resetData() {
    emit(state.copyWith(
      transactionItems: [],
      totalPrice: 0,
      selectedCategory: null,
      transaction: null,
      transactions: [],
      products: [],
      categories: [],
      transactionCategoryStatus: TransactionCategoryStatus.initial,
      transactionProductStatus: TransactionProductStatus.initial,
      transactionStatus: TransactionStatus.initial,
    ));
  }
}
