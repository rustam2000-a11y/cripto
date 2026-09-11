import '../data/models/coin_insight.dart';

abstract class InsightEvent {
  const InsightEvent();
}

class LoadInsightsEvent extends InsightEvent {
  const LoadInsightsEvent();
}

class InsightLoadingEvent extends InsightEvent {
  const InsightLoadingEvent({required this.isLoading});

  final bool isLoading;
}

class InsightsLoadedEvent extends InsightEvent {
  const InsightsLoadedEvent({required this.insights});

  final List<CoinInsight> insights;
}

class InsightLoadFailedEvent extends InsightEvent {
  const InsightLoadFailedEvent({required this.message});

  final String message;
}
