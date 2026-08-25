import '../../home/data/models/coin_model.dart';

abstract class BriefcaseEvent {
  const BriefcaseEvent();
}

class BriefcaseLoadingEvent extends BriefcaseEvent {
  const BriefcaseLoadingEvent({required this.isLoading});

  final bool isLoading;
}

class BriefcaseCoinsLoadedEvent extends BriefcaseEvent {
  const BriefcaseCoinsLoadedEvent({required this.coins});

  final List<CoinModel> coins;
}
