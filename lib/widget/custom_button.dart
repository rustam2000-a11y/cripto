import 'package:crypto_assistant/presentation/app_colors.dart';
import 'package:crypto_assistant/widget/custom_text.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.onTap});
final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.jacarta,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap:onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomNewText(text: 'Добавить в  избраное',fontSize: 16,fontWeight: FontWeight.w600,color: Colors.white,),
            ],
          ),
        ),
      ),
    );
  }
}
