import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:path_provider/path_provider.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState());

  String localImagePath = '';

  Future<void> getLocalStorageImagePath() async {
    final directory = await getApplicationDocumentsDirectory();
    String pathName = directory.path;

    localImagePath = pathName;
  }
}
