import 'package:crypto_assistant/presentation/app_colors.dart';
import 'package:crypto_assistant/widget/custom_text.dart';
import 'package:flutter/material.dart';

class TitleTextColumn extends StatelessWidget {
  const TitleTextColumn({
    super.key,
    required this.title,
    required this.text,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.fonSizeFirst,
    this.fonSizeLast,
  });

  final String title;
  final String text;
  final CrossAxisAlignment crossAxisAlignment;
  final double? fonSizeFirst;
  final double? fonSizeLast;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      spacing: 4,
      children: [
        CustomNewText(
          text: title,
          fontSize: fonSizeFirst ?? 14,
          fontWeight: FontWeight.w500,
          color: AppColors.titanWhite,
        ),
        CustomNewText(
          text: text,
          fontSize: fonSizeLast ?? 11,
          fontWeight: FontWeight.w500,
          color: AppColors.victoria,
        ),
      ],
    );
  }
}
