import 'dart:async';

import 'package:bloc_after_effect/bloc_after_effect.dart';
import 'package:injectable/injectable.dart';

import '../../home/data/models/coin_model.dart';
import '../../home/data/models/price_point.dart';
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
      _watchChart(event.coinId);
    });
    on<CoinLoadingEvent>((event, emit) {
      emit(state.copyWith(isLoading: event.isLoading));
    });
    on<CoinLoadedEvent>((event, emit) {
      emit(state.copyWith(coin: event.coin, isLoading: false));
    });
    on<ChartLoadingEvent>((event, emit) {
      emit(state.copyWith(isChartLoading: event.isLoading));
    });
    on<ChartLoadedEvent>((event, emit) {
      emit(state.copyWith(chartPoints: event.points, isChartLoading: false));
    });
  }

  final CoinRepositoryI _repository;
  StreamSubscription<CoinModel>? _coinSubscription;
  StreamSubscription<List<PricePoint>>? _chartSubscription;

  void _watchCoin(String coinId) {
    add(const CoinLoadingEvent(isLoading: true));
    _coinSubscription?.cancel();
    _coinSubscription = _repository.watchCoin(coinId).listen((coin) {
      add(CoinLoadedEvent(coin: coin));
    });
  }

  void _watchChart(String coinId) {
    add(const ChartLoadingEvent(isLoading: true));
    _chartSubscription?.cancel();
    _chartSubscription = _repository.watchMarketChart(coinId).listen((points) {
      add(ChartLoadedEvent(points: points));
    });
  }

  @override
  Future<void> close() {
    _coinSubscription?.cancel();
    _chartSubscription?.cancel();
    return super.close();
  }
}
