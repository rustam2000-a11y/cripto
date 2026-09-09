import 'package:crypto_assistant/core/ui/device_layout.dart';
import 'package:crypto_assistant/presentation/app_colors.dart';
import 'package:crypto_assistant/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/ui/ui_provider.dart';

class CoinPriceChange extends StatelessWidget {
  const CoinPriceChange({
    super.key,
    required this.currentPrice,
    required this.priceChangePercentage24h,
  });

  final double currentPrice;
  final double? priceChangePercentage24h;

  @override
  Widget build(BuildContext context) {
    final isTablet = context.watch<UiProvider>().deviceLayout.isTabletMode;
    final isPositive = (priceChangePercentage24h ?? 0) >= 0;
    final changeColor = isPositive ? Colors.green : Colors.red;
    final changeBgColor =
        isPositive ? Colors.green.withOpacity(0.15) : Colors.red.withOpacity(0.15);
    final changeText =
        '${isPositive ? '+' : ''}${(priceChangePercentage24h ?? 0).toStringAsFixed(2)}%';

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      spacing: 4,
      children: [
        CustomNewText(
          text: '\$${currentPrice.toStringAsFixed(2)}',
          fontSize: isTablet? 22:16,
          fontWeight: FontWeight.w500,
          color: AppColors.titanWhite,
        ),
        SizedBox(width: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: changeColor),
            color: changeBgColor,
          ),
          child: CustomNewText(
            text: changeText,
            fontSize: isTablet? 15:11,
            fontWeight: FontWeight.w500,
            color: changeColor,
          ),
        ),
      ],
    );
  }
}
