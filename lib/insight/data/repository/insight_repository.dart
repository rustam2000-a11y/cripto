import 'package:injectable/injectable.dart';

import '../../../home/data/models/coin_model.dart';
import '../../../home/data/repository/coint_rpository.dart';
import '../api/gemini_api.dart';
import '../models/coin_insight.dart';

@LazySingleton(as: InsightRepositoryI)
class InsightRepository extends InsightRepositoryI {
  InsightRepository({
    required CoinRepositoryI coinRepository,
    required GeminiApiI geminiApi,
  }) : _coinRepository = coinRepository,
       _geminiApi = geminiApi;

  static const _topCoinsCount = 10;
  static const _averagingDays = 14;
  // Бесплатная квота Gemini на этот запрос ограничена по дням, поэтому
  // повторные открытия экрана не должны каждый раз тратить новый запрос.
  static const _cacheTtl = Duration(minutes: 5);

  final CoinRepositoryI _coinRepository;
  final GeminiApiI _geminiApi;

  List<CoinInsight>? _cachedInsights;
  DateTime? _cachedAt;

  @override
  Future<List<CoinInsight>> loadInsights() async {
    final cached = _cachedInsights;
    final cachedAt = _cachedAt;
    if (cached != null &&
        cachedAt != null &&
        DateTime.now().difference(cachedAt) < _cacheTtl) {
      return cached;
    }

    final allCoins = await _coinRepository.watchCoins().first;
    final coins = _mostVolatile(allCoins, count: _topCoinsCount);

    final average14dPrices = <String, double>{
      for (final entry in await Future.wait(
        coins.map(
          (coin) => _average14dPrice(coin).then((avg) => MapEntry(coin.id, avg)),
        ),
      ))
        entry.key: entry.value,
    };

    final analyses = await _geminiApi.analyzeCoins(
      coins: coins,
      average14dPrices: average14dPrices,
    );

    final insights = [
      for (final coin in coins)
        if (analyses[coin.id] case final analysis?) (coin: coin, analysis: analysis),
    ];

    if (insights.isEmpty && coins.isNotEmpty) {
      throw StateError('Не удалось получить AI-аналитику ни по одной монете');
    }

    _cachedInsights = insights;
    _cachedAt = DateTime.now();
    return insights;
  }

  List<CoinModel> _mostVolatile(List<CoinModel> coins, {required int count}) {
    final sorted = [...coins]..sort(
      (a, b) => (b.priceChangePercentage24h?.abs() ?? 0).compareTo(
        a.priceChangePercentage24h?.abs() ?? 0,
      ),
    );
    return sorted.take(count).toList();
  }

  Future<double> _average14dPrice(CoinModel coin) async {
    try {
      final prices = await _coinRepository
          .watchMarketChart(coin.id, days: _averagingDays)
          .first;
      if (prices.isEmpty) return coin.currentPrice;
      return prices.map((point) => point.price).reduce((a, b) => a + b) /
          prices.length;
    } catch (_) {
      return coin.currentPrice;
    }
  }
}

abstract class InsightRepositoryI {
  Future<List<CoinInsight>> loadInsights();
}
