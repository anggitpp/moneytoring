import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubits/product/product_cubit.dart';

class AddProductPhoto extends StatelessWidget {
  const AddProductPhoto(
      {Key? key,
      required this.onTap,
      required this.isLoadedImage,
      this.imagePath})
      : super(key: key);

  final Function() onTap;
  final bool isLoadedImage;
  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      height: 110,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/photo_border.png'),
        ),
      ),
      alignment: Alignment.center,
      child: InkWell(
        onTap: onTap,
        child: imagePath != ''
            ? ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image(
                  image: FileImage(File(imagePath!)),
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                ),
              )
            : !isLoadedImage
                ? Container(
                    width: 90,
                    height: 90,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/photo.png'),
                      ),
                    ),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.file(
                      context.watch<ProductCubit>().image!,
                      width: 90,
                      height: 90,
                      fit: BoxFit.cover,
                    ),
                  ),
      ),
    );
  }
}
