part of 'add_category_cubit.dart';

class AddCategoryState extends Equatable {
  final String selectedIcon;
  AddCategoryState({
    required this.selectedIcon,
  });

  factory AddCategoryState.initial() {
    return AddCategoryState(selectedIcon: 'icon-electronic.png');
  }

  AddCategoryState copyWith({
    String? selectedIcon,
  }) {
    return AddCategoryState(
      selectedIcon: selectedIcon ?? this.selectedIcon,
    );
  }

  @override
  String toString() => 'AddCategoryState(selectedIcon: $selectedIcon)';

  @override
  List<Object> get props => [selectedIcon];
}
