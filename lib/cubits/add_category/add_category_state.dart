part of 'add_category_cubit.dart';

enum AddCategoryStatus {
  initial,
  submitting,
  finish,
  error,
}

class AddCategoryState extends Equatable {
  final String selectedIcon;
  final AddCategoryStatus addCategoryStatus;
  const AddCategoryState({
    required this.selectedIcon,
    required this.addCategoryStatus,
  });

  factory AddCategoryState.initial() {
    return const AddCategoryState(
        selectedIcon: 'icon-electronic.png',
        addCategoryStatus: AddCategoryStatus.initial);
  }

  AddCategoryState copyWith({
    String? selectedIcon,
    AddCategoryStatus? addCategoryStatus,
  }) {
    return AddCategoryState(
      selectedIcon: selectedIcon ?? this.selectedIcon,
      addCategoryStatus: addCategoryStatus ?? this.addCategoryStatus,
    );
  }

  @override
  String toString() =>
      'AddCategoryState(selectedIcon: $selectedIcon, addCategoryStatus: $addCategoryStatus)';

  @override
  List<Object> get props => [selectedIcon, addCategoryStatus];
}
