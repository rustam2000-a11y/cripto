import 'package:equatable/equatable.dart';

import '../../home/data/models/coin_model.dart';

class FilterDetailingState extends Equatable {
  const FilterDetailingState({
    this.coins = const [],
    this.isLoading = false
  });

  final List<CoinModel> coins;
  final bool isLoading;

  FilterDetailingState copyWith({List<CoinModel>? coins, bool? isLoading}) {
    return FilterDetailingState(
      coins: coins ?? this.coins,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [coins, isLoading];
}
