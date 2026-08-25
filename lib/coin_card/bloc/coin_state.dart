import 'package:equatable/equatable.dart';

import '../../home/data/models/coin_model.dart';
import '../../home/data/models/price_point.dart';

class CoinState extends Equatable {
  const CoinState({
    this.coin,
    this.isLoading = false,
    this.chartPoints = const [],
    this.isChartLoading = false,
    this.isFavorite = false,
  });

  final CoinModel? coin;
  final bool isLoading;
  final List<PricePoint> chartPoints;
  final bool isChartLoading;
  final bool isFavorite;

  CoinState copyWith({
    CoinModel? coin,
    bool? isLoading,
    List<PricePoint>? chartPoints,
    bool? isChartLoading,
    bool? isFavorite,
  }) {
    return CoinState(
      coin: coin ?? this.coin,
      isLoading: isLoading ?? this.isLoading,
      chartPoints: chartPoints ?? this.chartPoints,
      isChartLoading: isChartLoading ?? this.isChartLoading,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  List<Object?> get props => [
    coin,
    isLoading,
    chartPoints,
    isChartLoading,
    isFavorite,
  ];
}
