import '../../home/data/models/coin_model.dart';

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
