import 'package:crypto_assistant/presentation/app_colors.dart';
import 'package:crypto_assistant/widget/custom_text.dart';
import 'package:flutter/material.dart';

class TitleTextColumn extends StatelessWidget {
  const TitleTextColumn({
    super.key,
    required this.title,
    required this.text,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });

  final String title;
  final String text;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      spacing: 4,
      children: [
        CustomNewText(
          text: title,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.titanWhite,
        ),
        CustomNewText(
          text: text,
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: AppColors.victoria,
        ),
      ],
    );
  }
}
