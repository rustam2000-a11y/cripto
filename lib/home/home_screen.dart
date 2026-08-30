import 'package:crypto_assistant/home/bloc/home_bloc.dart';
import 'package:crypto_assistant/home/bloc/home_event.dart';
import 'package:crypto_assistant/home/bloc/home_state.dart';
import 'package:crypto_assistant/presentation/app_colors.dart';
import 'package:crypto_assistant/presentation/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../coin_card/coin_screen.dart';
import '../injection.dart';
import '../widget/coin_card.dart';
import 'home_widget/coin_search_field.dart';
import 'home_widget/custom_app_bar.dart';
import 'language/language_bottom_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeBloc _bloc;

  @override
  void initState() {
    _bloc = getIt<HomeBloc>();
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
      appBar: CustomAppBar(
        text: "Crypto Assistant",
        leadingIcon: false,
        action: InkWell(
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) {
                return LanguageBottomSheet();
              },
            );
          },
          child: Image.asset(AppImages.english, width: 24, height: 24),
        ),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        bloc: _bloc,
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.items.isEmpty) {
            return const Center(child: Text('Нет данных'));
          }
          return Column(
            children: [
              CoinSearchField(
                onChanged: (value) {
                  _bloc.add(SearchQueryChangedEvent(query: value));
                },
              ),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(8),
                  itemCount: state.filteredItems.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final coin = state.filteredItems[index];
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
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
