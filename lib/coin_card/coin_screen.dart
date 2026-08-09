import 'package:crypto_assistant/home/home_widget/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../injection.dart';
import '../presentation/app_colors.dart';
import '../widget/coin_avatar.dart';
import '../widget/coin_price_change.dart';
import '../widget/coin_price_chart.dart';
import '../widget/coin_stat_card.dart';
import '../widget/custom_text.dart';
import '../widget/format_utils.dart';
import '../widget/title_text_column.dart';
import 'bloc/coin_bloc.dart';
import 'bloc/coin_event.dart';
import 'bloc/coin_state.dart';

class CoinScreen extends StatefulWidget {
  const CoinScreen({super.key, required this.coinId});

  final String coinId;

  @override
  State<CoinScreen> createState() => _CoinScreenState();
}

class _CoinScreenState extends State<CoinScreen> {
  late final CoinBloc _bloc;

  @override
  void initState() {
    _bloc = getIt<CoinBloc>()..add(LoadCoinDetailsEvent(widget.coinId));
    super.initState();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoinBloc, CoinState>(
      bloc: _bloc,
      builder: (context, state) {
        final coin = state.coin;
        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: CustomAppBar(
            text: coin?.name ?? '',
            colors: AppColors.background,
          ),
          body: coin == null
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CoinAvatar(imageUrl: coin.image),
                          const SizedBox(width: 12),
                          TitleTextColumn(
                            title: coin.name,
                            text: '${coin.symbol.toUpperCase()} - #${coin.marketCapRank}',
                            fonSizeFirst: 18,
                            fonSizeLast: 14,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      CustomNewText(
                        text: '\$${coin.currentPrice.toStringAsFixed(2)}',
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                        color: AppColors.whiteColor,
                      ),
                      const SizedBox(height: 8),
                      CoinPriceChange(
                        currentPrice: coin.currentPrice,
                        priceChangePercentage24h: coin.priceChangePercentage24h,
                      ),
                      const SizedBox(height: 12),
                      CoinPriceChart(
                        points: state.chartPoints,
                        isLoading: state.isChartLoading,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        spacing: 12,
                        children: [
                          Expanded(
                            child: CoinStatCard(
                              title: 'Объём 24 часа',
                              value: formatVolume(coin.totalVolume),
                            ),
                          ),
                          Expanded(
                            child: CoinStatCard(
                              title: 'Макс 24 часа',
                              value: coin.high24h != null
                                  ? '\$${coin.high24h!.toStringAsFixed(2)}'
                                  : '—',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
