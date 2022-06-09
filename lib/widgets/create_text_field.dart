import 'package:flutter/material.dart';

import '../../../config/theme.dart';

class CreateTextField extends StatelessWidget {
  final String label;
  final String textHint;
  const CreateTextField({
    Key? key,
    required this.label,
    required this.textHint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyle.largeText,
        ),
        const SizedBox(
          height: 6,
        ),
        TextField(
          decoration: InputDecoration(
            hintText: textHint,
            hintStyle: AppTextStyle.greyMediumText,
            contentPadding: const EdgeInsets.all(17),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.yellowColor),
              borderRadius: BorderRadius.circular(8),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.greyColor),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }
}
