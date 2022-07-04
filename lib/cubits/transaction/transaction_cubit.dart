import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:moneytoring/models/product.dart';
import 'package:moneytoring/models/transaction_item.dart';
import 'package:sqflite/sqflite.dart';

import 'package:moneytoring/repository/category_repository.dart';
import 'package:moneytoring/repository/repositories.dart';

import '../../models/category.dart';

part 'transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  TransactionCubit({
    required this.categoryRepository,
    required this.productRepository,
  }) : super(TransactionState.initial());

  final CategoryRepository categoryRepository;
  final ProductRepository productRepository;

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

    emit(state.copyWith(
        transactionProductStatus: TransactionProductStatus.loaded,
        products: products));
  }

  void onPressCategory(Category category) {
    emit(state.copyWith(selectedCategory: category));
  }

  void onPressProduct(TransactionItem transactionItem) {
    var contain = state.transactionItems
        .where((element) => element.product == transactionItem.product);

    if (contain.isEmpty) {
      emit(state.copyWith(
          transactionItems: [...state.transactionItems, transactionItem]));
    } else {
      final items = [
        for (final item in state.transactionItems)
          if (item == contain.first)
            item.copyWith(amount: item.amount + 1)
          else
            item
      ];

      emit(
        state.copyWith(transactionItems: items),
      );
    }
  }
}
