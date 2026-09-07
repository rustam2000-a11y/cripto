import 'package:crypto_assistant/presentation/app_colors.dart';
import 'package:crypto_assistant/widget/custom_text.dart';
import 'package:flutter/material.dart';

import '../../generated/l10n.dart';



class BottomSheetWrapper extends StatelessWidget {
  const BottomSheetWrapper({
    super.key,
    required this.body,
     this.bottomWidget,
  });

  final Widget body;
  final Widget? bottomWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        maxHeight: 400,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
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
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomNewText(
                      text: S.of(context).language,
                      fontSize: 20,
                    ),
                    Material(
                      shape: const CircleBorder(),
                      color: AppColors.closeButtonBackground,
                      child: InkWell(
                        onTap: ()=> Navigator.pop(context),
                        customBorder: const CircleBorder(),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Icon(
                            Icons.close,
                            color: AppColors.closeIcon,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                body,
              ],
            ),
          ),
          SafeArea(
            child: bottomWidget??SizedBox(),
          ),
        ],
      ),
    );
  }
}
