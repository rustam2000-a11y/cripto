import 'package:crypto_assistant/presentation/app_colors.dart';
import 'package:crypto_assistant/widget/custom_text.dart';
import 'package:flutter/material.dart';

class CoinCard extends StatelessWidget {
  const CoinCard({
    super.key,
    required this.name,
    required this.symbol,
    required this.imageUrl,
    required this.currentPrice,
    required this.priceChangePercentage24h,
    required this.totalVolume,
    required this.high24h,
    required this.marketCapRank,
  });

  final String name;
  final String symbol;
  final String imageUrl;
  final double currentPrice;
  final double? priceChangePercentage24h;
  final int totalVolume;
  final double? high24h;
  final int marketCapRank;

  @override
  Widget build(BuildContext context) {
    final isPositive = (priceChangePercentage24h ?? 0) >= 0;
    final changeColor = isPositive ? Colors.green : Colors.red;
    final changeBgColor = isPositive ? Colors.green.withOpacity(0.15) : Colors.red.withOpacity(0.15);
    final changeText =
        '${isPositive ? '+' : ''}${(priceChangePercentage24h ?? 0).toStringAsFixed(2)}%';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.containerColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.jacarta),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: 42,
                    width: 42,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const Icon(Icons.currency_bitcoin),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 4,
                    children: [
                      CustomNewText(
                        text: name,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.titanWhite,
                      ),
                      CustomNewText(
                        text: '${symbol.toUpperCase()} - #$marketCapRank',
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: AppColors.victoria,
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                spacing: 4,
                children: [
                  CustomNewText(
                    text: '\$${currentPrice.toStringAsFixed(2)}',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.titanWhite,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: changeColor),
                      color: changeBgColor,
                    ),
                    child: CustomNewText(
                      text: changeText,
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: changeColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 4,
                  children: [
                    CustomNewText(text: 'Объём 24 часа', fontSize: 11, color: AppColors.victoria),
                    CustomNewText(
                      text: _formatVolume(totalVolume),
                      fontSize: 13,
                      color: AppColors.blueBell,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 4,
                  children: [
                    CustomNewText(text: 'Макс 24 часа', fontSize: 11, color: AppColors.victoria),
                    CustomNewText(
                      text: high24h != null ? '\$${high24h!.toStringAsFixed(2)}' : '—',
                      fontSize: 13,
                      color: AppColors.blueBell,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatVolume(int volume) {
    if (volume >= 1000000000) return '${(volume / 1000000000).toStringAsFixed(1)}B';
    if (volume >= 1000000) return '${(volume / 1000000).toStringAsFixed(1)}M';
    if (volume >= 1000) return '${(volume / 1000).toStringAsFixed(1)}K';
    return volume.toString();
  }
}
