import 'dart:async';

import 'package:bloc_after_effect/bloc_after_effect.dart';
import 'package:injectable/injectable.dart';

import '../data/models/coin_model.dart';
import '../data/repository/coint_rpository.dart';
import 'home_effect.dart';
import 'home_event.dart';
import 'home_state.dart';

@injectable
class HomeBloc extends EffectBloc<HomeEvent, HomeState, HomeEffect> {
  HomeBloc({required CoinRepositoryI repository})
    : _repository = repository,
      super(const HomeState()) {
    on<LoadingEvent>((event, emit) {
      emit(state.copyWith(isLoading: event.isLoading));
    });
    on<LoadItemsEvent>((event, emit) {
      emit(state.copyWith(items: event.items, isLoading: false));
    });
    _init();
  }

  final CoinRepositoryI _repository;
StreamSubscription <List<CoinModel>>? _coinsSubscription;

  void _init() {
    add(LoadingEvent(isLoading: true));
    _coinsSubscription = _repository.watchCoins().listen((coins) {
      add(LoadItemsEvent(items: coins));
    });
  }

  @override
  Future<void> close() {
    _coinsSubscription?.cancel();
    return super.close();
  }
}
