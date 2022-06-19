import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubits/product/product_cubit.dart';

class AddProductPhoto extends StatelessWidget {
  const AddProductPhoto({
    Key? key,
    required this.onTap,
    required this.isLoadedImage,
  }) : super(key: key);

  final Function() onTap;
  final bool isLoadedImage;

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
        child: !isLoadedImage
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
