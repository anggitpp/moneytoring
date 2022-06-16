part of 'category_cubit.dart';

enum CategoryStatus {
  initial,
  loading,
  loaded,
  error,
}

class CategoryState extends Equatable {
  final CategoryStatus categoryStatus;
  final List<Category> categories;
  const CategoryState({
    required this.categoryStatus,
    required this.categories,
  });

  factory CategoryState.initial() => CategoryState(
        categoryStatus: CategoryStatus.initial,
        categories: const [],
      );

  CategoryState copyWith({
    CategoryStatus? categoryStatus,
    List<Category>? categories,
  }) {
    return CategoryState(
      categoryStatus: categoryStatus ?? this.categoryStatus,
      categories: categories ?? this.categories,
    );
  }

  @override
  String toString() =>
      'CategoryState(categoryStatus: $categoryStatus, categories: $categories)';

  @override
  List<Object> get props => [categoryStatus, categories];
}
