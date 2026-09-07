import '../../home/data/models/chart_period.dart';
import '../../home/data/models/coin_model.dart';
import '../../home/data/models/price_point.dart';

abstract class CoinEvent {
  const CoinEvent();
}

class LoadCoinDetailsEvent extends CoinEvent {
  const LoadCoinDetailsEvent(this.coinId);

  final String coinId;
}

class CoinLoadingEvent extends CoinEvent {
  const CoinLoadingEvent({required this.isLoading});

  final bool isLoading;
}

class CoinLoadedEvent extends CoinEvent {
  const CoinLoadedEvent({required this.coin});

  final CoinModel coin;
}

class ChartLoadingEvent extends CoinEvent {
  const ChartLoadingEvent({required this.isLoading});

  final bool isLoading;
}

class ChartLoadedEvent extends CoinEvent {
  const ChartLoadedEvent({required this.points});

  final List<PricePoint> points;
}

class ToggleBriefcaseEvent extends CoinEvent {
  const ToggleBriefcaseEvent();
}

class BriefcaseStatusLoadedEvent extends CoinEvent {
  const BriefcaseStatusLoadedEvent({required this.isFavorite});

  final bool isFavorite;
}

class ChangeChartPeriodEvent extends CoinEvent {
  const ChangeChartPeriodEvent(this.period);

  final ChartPeriod period;
}

class ChartPeriodChangedEvent extends CoinEvent {
  const ChartPeriodChangedEvent(this.period);

  final ChartPeriod period;
}