import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moneytoring/config/constant.dart';
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
    var db = await openDatabase(databaseApplication);

    List<Category> categories = await categoryRepository.getCategories(db);

    emit(state.copyWith(
        productCategoryStatus: ProductCategoryStatus.loaded,
        categories: categories));

    db.close();
  }

  void loadProducts() async {
    emit(state.copyWith(productStatus: ProductStatus.loading));

    var db = await openDatabase(databaseApplication);

    List<Product> products = await productRepository.getProducts(db);

    emit(state.copyWith(
        productStatus: ProductStatus.loaded, products: products));
  }

  void loadProduct(int id) async {
    try {
      emit(state.copyWith(addProductStatus: AddProductStatus.loading));

      var db = await openDatabase(databaseApplication);

      Product? product = await productRepository.getProductById(db, id);

      emit(state.copyWith(
          addProductStatus: AddProductStatus.loaded,
          product: product,
          imagePath: product?.imagePath));
    } catch (e) {
      emit(state.copyWith(addProductStatus: AddProductStatus.error));
    }
  }

  void insertProduct(Product product) async {
    var db = await openDatabase(databaseApplication);

    emit(state.copyWith(addProductStatus: AddProductStatus.submitting));

    try {
      await productRepository.insert(db, product);

      Directory duplicateFilePath = await getApplicationDocumentsDirectory();
      String duplicateFileName = duplicateFilePath.path;

      var fileName = basename(image!.path);
      await image!.copy('$duplicateFileName/$fileName');

      List<Product> products = await productRepository.getProducts(db);

      emit(state.copyWith(
          addProductStatus: AddProductStatus.success,
          products: products,
          isLoadedImage: false,
          imagePath: ''));
    } catch (e) {
      emit(state.copyWith(addProductStatus: AddProductStatus.error));
    }
  }

  void updateProduct(Product product, int id) async {
    var db = await openDatabase(databaseApplication);

    emit(state.copyWith(addProductStatus: AddProductStatus.submitting));

    try {
      await productRepository.update(db, product, id);

      if (state.isLoadedImage) {
        Product? product = await productRepository.getProductById(db, id);

        await deleteFile(File(product!.imagePath));

        Directory duplicateFilePath = await getApplicationDocumentsDirectory();
        String duplicateFileName = duplicateFilePath.path;

        var fileName = basename(image!.path);
        await image!.copy('$duplicateFileName/$fileName');
      }

      List<Product> products = await productRepository.getProducts(db);

      emit(state.copyWith(
          addProductStatus: AddProductStatus.success,
          products: products,
          isLoadedImage: false,
          imagePath: ''));
    } catch (e) {
      emit(state.copyWith(addProductStatus: AddProductStatus.error));
    }
  }

  void deleteProduct(int id) async {
    try {
      emit(state.copyWith(addProductStatus: AddProductStatus.submitting));
      var db = await openDatabase(databaseApplication);

      Product? product = await productRepository.getProductById(db, id);

      await deleteFile(File(product!.imagePath));

      await productRepository.deleteProduct(db, id);
      List<Product> products = await productRepository.getProducts(db);

      emit(
        state.copyWith(
            addProductStatus: AddProductStatus.success,
            products: products,
            isLoadedImage: false,
            imagePath: ''),
      );
    } catch (e) {
      emit(state.copyWith(addProductStatus: AddProductStatus.error));
    }
  }

  Future<void> deleteFile(File file) async {
    try {
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future getImage() async {
    var pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    image = File(pickedImage!.path); // won't have any error now

    emit(state.copyWith(imagePath: pickedImage.name));
  }

  void reset() {
    emit(state.copyWith(
      isLoadedImage: false,
      imagePath: '',
      productStatus: ProductStatus.initial,
      productCategoryStatus: ProductCategoryStatus.initial,
      addProductStatus: AddProductStatus.initial,
    ));
  }
}
