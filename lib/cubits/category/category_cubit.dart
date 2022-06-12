import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:moneytoring/repository/category_repository.dart';
import 'package:sqflite/sqflite.dart';

import '../../models/category.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final CategoryRepository categoryRepository;

  CategoryCubit({
    required this.categoryRepository,
  }) : super(CategoryState.initial());

  void loadCategories() async {
    emit(state.copyWith(categoryStatus: CategoryStatus.loading));
    var db = await openDatabase('moneytoring.db');

    List<Category> categories = await categoryRepository.getCategories(db);

    emit(state.copyWith(
        categoryStatus: CategoryStatus.loaded, categories: categories));

    db.close();
  }
}
