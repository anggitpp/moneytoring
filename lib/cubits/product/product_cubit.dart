import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moneytoring/repository/repositories.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../../models/category.dart';
import '../../models/product.dart';
import 'package:path/path.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit({
    required this.categoryRepository,
    required this.productRepository,
  }) : super(ProductState.initial());
  final CategoryRepository categoryRepository;
  final ProductRepository productRepository;

  File? image;

  void uploadImage() {
    getImage().then((value) {
      emit(state.copyWith(isLoadedImage: true));
    });
  }

  void loadCategories() async {
    emit(state.copyWith(productCategoryStatus: ProductCategoryStatus.loading));
    var db = await openDatabase('moneytoring.db');

    List<Category> categories = await categoryRepository.getCategories(db).then(
        (value) => value
            .where((element) => element.categoryType == CategoryType.income)
            .toList());

    emit(state.copyWith(
        productCategoryStatus: ProductCategoryStatus.loaded,
        categories: categories));

    db.close();
  }

  void loadProducts() async {
    emit(state.copyWith(productStatus: ProductStatus.loading));

    var db = await openDatabase('moneytoring.db');

    List<Product> products = await productRepository.getProducts(db);

    emit(state.copyWith(
        productStatus: ProductStatus.loaded, products: products));
  }

  void insertProduct(Product product) async {
    var db = await openDatabase('moneytoring.db');

    emit(state.copyWith(addProductStatus: AddProductStatus.submitting));

    try {
      await db.delete('products');

      await productRepository.insert(db, product);

      Directory duplicateFilePath = await getApplicationDocumentsDirectory();
      String duplicateFileName = duplicateFilePath.path;

      var fileName = basename(image!.path);
      await image!.copy('$duplicateFileName/$fileName');

      emit(state.copyWith(addProductStatus: AddProductStatus.success));
    } catch (e) {
      emit(state.copyWith(addProductStatus: AddProductStatus.error));
    }
  }

  Future getImage() async {
    var pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    image = File(pickedImage!.path); // won't have any error now
    emit(state.copyWith(imagePath: pickedImage.path));
  }
}
