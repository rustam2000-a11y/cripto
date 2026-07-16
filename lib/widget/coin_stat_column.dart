import 'package:crypto_assistant/presentation/app_colors.dart';
import 'package:crypto_assistant/widget/custom_text.dart';
import 'package:flutter/material.dart';

class CoinStatColumn extends StatelessWidget {
  const CoinStatColumn({
    super.key,
    required this.title,
    required this.text,
  });

  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 4,
      children: [
        CustomNewText(text: title, fontSize: 11, color: AppColors.victoria),
        CustomNewText(
          text: text,
          fontSize: 13,
          color: AppColors.blueBell,
          fontWeight: FontWeight.w500,
        ),
      ],
    );
  }
}
