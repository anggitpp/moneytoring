import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'add_category_state.dart';

class AddCategoryCubit extends Cubit<AddCategoryState> {
  AddCategoryCubit() : super(AddCategoryState.initial());

  void changeImage(image) {
    emit(state.copyWith(selectedIcon: image));
  }
}
