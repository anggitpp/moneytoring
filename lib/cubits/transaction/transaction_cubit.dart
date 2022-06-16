import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:moneytoring/repository/category_repository.dart';
import 'package:sqflite/sqflite.dart';

import '../../models/category.dart';

part 'transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  TransactionCubit({
    required this.categoryRepository,
  }) : super(TransactionState.initial());

  final CategoryRepository categoryRepository;

  void loadCategories() async {
    emit(state.copyWith(
        transactionCategoryStatus: TransactionCategoryStatus.loading));
    var db = await openDatabase('moneytoring.db');

    List<Category> categories = await categoryRepository.getCategories(db);

    emit(state.copyWith(
        transactionCategoryStatus: TransactionCategoryStatus.loaded,
        categories: categories));

    db.close();
  }

  void onPressCategory(Category category) {
    emit(state.copyWith(selectedCategory: category));
  }
}
