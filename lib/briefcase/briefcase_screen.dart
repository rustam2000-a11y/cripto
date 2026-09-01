import 'package:bloc_after_effect/bloc_after_effect.dart';
import 'package:flutter/material.dart';

import '../coin_card/coin_screen.dart';
import '../home/home_widget/custom_app_bar.dart';
import '../generated/l10n.dart';
import '../injection.dart';
import '../presentation/app_colors.dart';
import '../widget/coin_card.dart';
import 'bloc/briefcase_bloc.dart';
import 'bloc/briefcase_effect.dart';
import 'bloc/briefcase_state.dart';

class BriefcaseScreen extends StatefulWidget {
  const BriefcaseScreen({super.key});

  @override
  State<BriefcaseScreen> createState() => _BriefcaseScreenState();
}

class _BriefcaseScreenState extends State<BriefcaseScreen> {
  late final BriefcaseBloc _bloc;

  @override
  void initState() {
    _bloc = getIt<BriefcaseBloc>();
    super.initState();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.haiti,
      appBar: const CustomAppBar(text: 'Мой портфель', leadingIcon: false),
      body: BlocEffectBuilder<BriefcaseBloc, BriefcaseState, BriefcaseEffect>(
        bloc: _bloc,
        effectListener: (context, effect) {},
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.coins.isEmpty) {
            return Center(child: Text(S.of(context).noItemsAddedYet));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: state.coins.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final coin = state.coins[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CoinScreen(coinId: coin.id),
                    ),
                  );
                },
                child: CoinCard(
                  name: coin.name,
                  symbol: coin.symbol,
                  imageUrl: coin.image,
                  currentPrice: coin.currentPrice,
                  priceChangePercentage24h: coin.priceChangePercentage24h,
                  totalVolume: coin.totalVolume,
                  high24h: coin.high24h,
                  marketCapRank: coin.marketCapRank,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
