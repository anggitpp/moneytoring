import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:moneytoring/models/category.dart';

import 'package:moneytoring/repository/category_repository.dart';
import 'package:sqflite/sqflite.dart';

part 'add_category_state.dart';

class AddCategoryCubit extends Cubit<AddCategoryState> {
  CategoryRepository categoryRepository;
  AddCategoryCubit({
    required this.categoryRepository,
  }) : super(AddCategoryState.initial());

  void changeImage(image) {
    emit(state.copyWith(
        selectedIcon: image, addCategoryStatus: AddCategoryStatus.initial));
  }

  void insertCategory(Category category) async {
    var db = await openDatabase('moneytoring.db');

    emit(state.copyWith(addCategoryStatus: AddCategoryStatus.submitting));

    await categoryRepository.insert(db, category);

    emit(state.copyWith(addCategoryStatus: AddCategoryStatus.finish));
  }

  void updateCategory(Category category) async {
    var db = await openDatabase('moneytoring.db');

    emit(state.copyWith(addCategoryStatus: AddCategoryStatus.submitting));

    await categoryRepository.update(db, category);

    emit(state.copyWith(addCategoryStatus: AddCategoryStatus.finish));
  }

  void getCategory(Category category) {
    emit(state.copyWith(addCategoryStatus: AddCategoryStatus.loading));

    emit(state.copyWith(
        addCategoryStatus: AddCategoryStatus.loaded,
        category: category,
        selectedIcon: category.imagePath.replaceAll('assets/icon/', '')));
  }

  void resetData() {
    emit(
      state.copyWith(
          addCategoryStatus: AddCategoryStatus.initial,
          category: const Category(
              categoryType: CategoryType.income, name: '', imagePath: ''),
          selectedIcon: 'icon-electronic.png'),
    );
  }
}
