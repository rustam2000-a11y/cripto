import 'package:crypto_assistant/presentation/app_images.dart';
import 'package:flutter/material.dart';
import 'bottom_sheet_wrapper.dart';
import 'language_card_widget.dart';

class LanguageBottomSheet extends StatelessWidget {
  const LanguageBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomSheetWrapper(
      onTapButton: () {  },
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            spacing: 8,
            children: [
              LanguageCardWidget(
                active: true,
                icon: AppImages.englishFlag,
                language: 'English',
                  onTap:(){},
              ),
              LanguageCardWidget(
                active: true,
                icon: AppImages.russianFlag,
                language: 'Русский',
                onTap:(){},
              ),
            ],
          ),

        ],
      ), 
    );
  }
}
