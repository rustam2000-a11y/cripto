import '../home/data/models/coin_model.dart';

String formatVolume(int volume) {
  if (volume >= 1000000000000) return '${(volume / 1000000000000).toStringAsFixed(1)}T';
  if (volume >= 1000000000) return '${(volume / 1000000000).toStringAsFixed(1)}B';
  if (volume >= 1000000) return '${(volume / 1000000).toStringAsFixed(1)}M';
  if (volume >= 1000) return '${(volume / 1000).toStringAsFixed(1)}K';
  return volume.toString();
}

String formatPriceRangePosition(double currentPrice, double? low24h, double? high24h) {
  if (low24h == null || high24h == null || high24h == low24h) return '—';
  final position = ((currentPrice - low24h) / (high24h - low24h) * 100).clamp(0, 100);
  return '${position.toStringAsFixed(0)}%';
}

abstract class CoinFilter {
  List<CoinModel> filter(List<CoinModel> coins);
}

// Аномальное движение цены за последние 24 часа: рост/падение выше чем на 10%.
class AbnormalMovementFilter extends CoinFilter {
  static const double _thresholdPercent = 10;

  @override
  List<CoinModel> filter(List<CoinModel> coins) {
    return coins
        .where((coin) => (coin.priceChangePercentage24h ?? 0).abs() > _thresholdPercent)
        .toList();
  }
}

// Движение цены за последние 24 часа: рост/падение выше чем на 5%.
class PriceMovementFilter extends CoinFilter {
  static const double _thresholdPercent = 5;

  @override
  List<CoinModel> filter(List<CoinModel> coins) {
    return coins
        .where((coin) => (coin.priceChangePercentage24h ?? 0).abs() > _thresholdPercent)
        .toList();
  }
}

// Большая волатильность: размах между high24h и low24h относительно текущей цены.
class HighVolatilityFilter extends CoinFilter {
  static const double _thresholdPercent = 10;

  @override
  List<CoinModel> filter(List<CoinModel> coins) {
    return coins.where((coin) {
      final high = coin.high24h;
      final low = coin.low24h;
      if (high == null || low == null || coin.currentPrice == 0) return false;
      final rangePercent = (high - low) / coin.currentPrice * 100;
      return rangePercent > _thresholdPercent;
    }).toList();
  }
}

// Исторический максимум/минимум: цена приблизилась к ATH или ATL.
class HistoricalExtremumFilter extends CoinFilter {
  static const double _thresholdPercent = 5;

  @override
  List<CoinModel> filter(List<CoinModel> coins) {
    return coins.where((coin) {
      final athChange = coin.athChangePercentage;
      final atlChange = coin.atlChangePercentage;
      final nearAth = athChange != null && athChange.abs() <= _thresholdPercent;
      final nearAtl = atlChange != null && atlChange.abs() <= _thresholdPercent;
      return nearAth || nearAtl;
    }).toList();
  }
}

// Оборачиваемость: аномально высокий объём торгов относительно капитализации.
class TurnoverFilter extends CoinFilter {
  static const double _thresholdRatio = 0.5;

  @override
  List<CoinModel> filter(List<CoinModel> coins) {
    return coins.where((coin) {
      if (coin.marketCap == 0) return false;
      final turnoverRatio = coin.totalVolume / coin.marketCap;
      return turnoverRatio > _thresholdRatio;
    }).toList();
  }
}

// Приток капитала: рост/отток капитализации выше 5% за 24 часа.
class CapitalInflowFilter extends CoinFilter {
  static const double _thresholdPercent = 5;

  @override
  List<CoinModel> filter(List<CoinModel> coins) {
    return coins
        .where((coin) => (coin.marketCapChangePercentage24h ?? 0).abs() > _thresholdPercent)
        .toList();
  }
}

// У дневного пика/дна: текущая цена у верхней или нижней границы диапазона high24h/low24h.
class DailyExtremumFilter extends CoinFilter {
  static const double _thresholdPercent = 5;

  @override
  List<CoinModel> filter(List<CoinModel> coins) {
    return coins.where((coin) {
      final high = coin.high24h;
      final low = coin.low24h;
      if (high == null || low == null || high == low) return false;
      final position = (coin.currentPrice - low) / (high - low) * 100;
      return position <= _thresholdPercent || position >= 100 - _thresholdPercent;
    }).toList();
  }
}

// Подтверждённая аномалия: аномальное движение цены, подтверждённое высоким объёмом торгов.
class ConfirmedAnomalyFilter extends CoinFilter {
  static const double _priceThresholdPercent = 10;
  static const double _turnoverThresholdRatio = 0.5;

  @override
  List<CoinModel> filter(List<CoinModel> coins) {
    return coins.where((coin) {
      final priceAnomaly = (coin.priceChangePercentage24h ?? 0).abs() > _priceThresholdPercent;
      if (!priceAnomaly || coin.marketCap == 0) return false;
      final turnoverRatio = coin.totalVolume / coin.marketCap;
      return turnoverRatio > _turnoverThresholdRatio;
    }).toList();
  }
}

