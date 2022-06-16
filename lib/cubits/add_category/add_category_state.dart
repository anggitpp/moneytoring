part of 'add_category_cubit.dart';

enum AddCategoryStatus {
  initial,
  loading,
  loaded,
  submitting,
  finish,
  error,
}

class AddCategoryState extends Equatable {
  final String selectedIcon;
  final AddCategoryStatus addCategoryStatus;
  final Category category;
  const AddCategoryState({
    required this.selectedIcon,
    required this.addCategoryStatus,
    required this.category,
  });

  factory AddCategoryState.initial() {
    return const AddCategoryState(
        selectedIcon: 'icon-electronic.png',
        addCategoryStatus: AddCategoryStatus.initial,
        category: Category(
            categoryType: CategoryType.income, name: '', imagePath: ''));
  }

  AddCategoryState copyWith({
    String? selectedIcon,
    AddCategoryStatus? addCategoryStatus,
    Category? category,
  }) {
    return AddCategoryState(
      selectedIcon: selectedIcon ?? this.selectedIcon,
      addCategoryStatus: addCategoryStatus ?? this.addCategoryStatus,
      category: category ?? this.category,
    );
  }

  @override
  String toString() =>
      'AddCategoryState(selectedIcon: $selectedIcon, addCategoryStatus: $addCategoryStatus, category: $category)';

  @override
  List<Object> get props => [selectedIcon, addCategoryStatus, category];
}
