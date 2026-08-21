import 'package:crypto_assistant/presentation/app_colors.dart';
import 'package:crypto_assistant/widget/custom_text.dart';
import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        Expanded(
          child: Container(height: 1,
          decoration: BoxDecoration(
            color: AppColors.textSecondary,
            borderRadius: BorderRadius.circular(20),
          ),
          ),
        ),
        CustomNewText(text: 'or',color: AppColors.textSecondary,),
        Expanded(
          child: Container(height: 1,
            decoration: BoxDecoration(
              color: AppColors.textSecondary,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ],

    ) ;
  }
}
