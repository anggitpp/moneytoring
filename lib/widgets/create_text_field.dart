import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../config/theme.dart';

class CreateTextField extends StatelessWidget {
  final String label;
  final String textHint;
  final TextEditingController controller;
  final bool isNumber;
  final int? maxLength;
  const CreateTextField({
    Key? key,
    required this.label,
    required this.textHint,
    required this.controller,
    this.isNumber = false,
    this.maxLength,
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
          keyboardType: isNumber ? TextInputType.number : TextInputType.text,
          controller: controller,
          textAlign: isNumber ? TextAlign.end : TextAlign.start,
          maxLength: maxLength,
          inputFormatters: isNumber
              ? [
                  FilteringTextInputFormatter.digitsOnly,
                ]
              : [],
          decoration: InputDecoration(
            counterText: '',
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
