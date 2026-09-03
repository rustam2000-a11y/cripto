import 'package:crypto_assistant/presentation/app_colors.dart';
import 'package:crypto_assistant/widget/coin_avatar.dart';
import 'package:crypto_assistant/widget/coin_price_change.dart';
import 'package:crypto_assistant/widget/custom_text.dart';
import 'package:crypto_assistant/widget/title_text_column.dart';
import 'package:flutter/material.dart';

import '../data/models/coin_insight.dart';

class InsightCard extends StatelessWidget {
  const InsightCard({super.key, required this.insight});

  final CoinInsight insight;

  @override
  Widget build(BuildContext context) {
    final coin = insight.coin;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.containerColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.jacarta),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Row(
                  children: [
                    CoinAvatar(imageUrl: coin.image),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TitleTextColumn(
                        title: coin.name,
                        text:
                            '${coin.symbol.toUpperCase()} - #${coin.marketCapRank}',
                      ),
                    ),
                  ],
                ),
              ),
              CoinPriceChange(
                currentPrice: coin.currentPrice,
                priceChangePercentage24h: coin.priceChangePercentage24h,
              ),
            ],
          ),
          const SizedBox(height: 12),
          CustomNewText(
            text: insight.analysis,
            textAlign: TextAlign.start,
            color: AppColors.textSecondary,
            fontSize: 13,
            height: 1.4,
          ),
        ],
      ),
    );
  }
}
