import 'package:crypto_assistant/presentation/app_colors.dart';
import 'package:crypto_assistant/widget/custom_text.dart';
import 'package:flutter/material.dart';

import '../../widget/custom_button.dart';

class BottomSheetWrapper extends StatelessWidget {
  const BottomSheetWrapper({super.key, required this.body, required this.onTapButton});
final Widget body;
final VoidCallback onTapButton;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12,vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.sheetBackground,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Container(
                  height: 3,
                  width: 30,
                  decoration: BoxDecoration(
                    color: AppColors.sheetHandle,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomNewText(text: 'Language',fontSize: 20,),
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.closeButtonBackground,
                        shape: BoxShape.circle
                      ),
                      child: Icon(Icons.close,color: AppColors.closeIcon,),
                    )
                  ],
                ),
                SizedBox(height: 20,),
                body
              ],
            ),
          ),
          SafeArea(child: CustomButton(onTap: (){}, name: 'apply')),
        ],

      ),

    );
  }
}
