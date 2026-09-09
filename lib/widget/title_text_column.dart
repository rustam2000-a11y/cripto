import 'package:crypto_assistant/core/ui/device_layout.dart';
import 'package:crypto_assistant/presentation/app_colors.dart';
import 'package:crypto_assistant/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/ui/ui_provider.dart';


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
    final isTablet = context.watch<UiProvider>().deviceLayout.isTabletMode;
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      spacing: 4,
      children: [
        CustomNewText(
          text: title,
          fontSize: fonSizeFirst ?? (isTablet ? 18 : 14),
          fontWeight: FontWeight.w500,
          color: AppColors.titanWhite,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        CustomNewText(
          text: text,
          fontSize: fonSizeFirst ?? (isTablet ? 18 : 12),
          fontWeight: FontWeight.w500,
          color: AppColors.victoria,
        ),
      ],
    );
  }
}
