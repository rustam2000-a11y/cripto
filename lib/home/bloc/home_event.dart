import '../data/models/coin_model.dart';

abstract class HomeEvent {
  const HomeEvent();
}

class LoadingEvent extends HomeEvent {
  const LoadingEvent({required this.isLoading});

  final bool isLoading;
}
class LoadItemsEvent extends HomeEvent {
  LoadItemsEvent({ required this.items});
  final List <CoinModel> items;
}


