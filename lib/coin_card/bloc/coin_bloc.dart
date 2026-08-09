import 'dart:async';

import 'package:bloc_after_effect/bloc_after_effect.dart';
import 'package:injectable/injectable.dart';

import '../../home/data/models/coin_model.dart';
import '../../home/data/repository/coint_rpository.dart';
import 'coin_effect.dart';
import 'coin_event.dart';
import 'coin_state.dart';

@injectable
class CoinBloc extends EffectBloc<CoinEvent, CoinState, CoinEffect> {
  CoinBloc({required CoinRepositoryI repository})
    : _repository = repository,
      super(const CoinState()) {
    on<LoadCoinDetailsEvent>((event, emit) {
      _watchCoin(event.coinId);
    });
    on<CoinLoadingEvent>((event, emit) {
      emit(state.copyWith(isLoading: event.isLoading));
    });
    on<CoinLoadedEvent>((event, emit) {
      emit(state.copyWith(coin: event.coin, isLoading: false));
    });
  }

  final CoinRepositoryI _repository;
  StreamSubscription<CoinModel>? _coinSubscription;

  void _watchCoin(String coinId) {
    add(const CoinLoadingEvent(isLoading: true));
    _coinSubscription?.cancel();
    _coinSubscription = _repository.watchCoin(coinId).listen((coin) {
      add(CoinLoadedEvent(coin: coin));
    });
  }

  @override
  Future<void> close() {
    _coinSubscription?.cancel();
    return super.close();
  }
}
