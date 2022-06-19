import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moneytoring/repository/repositories.dart';
import 'package:sqflite/sqflite.dart';

import '../../models/category.dart';
import '../../models/product.dart';
import '../../repository/category_repository.dart';

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

    db.close();
  }

  Future getImage() async {
    var pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    image = File(pickedImage!.path); // won't have any error now
    emit(state.copyWith(imagePath: pickedImage.path));
  }
}
