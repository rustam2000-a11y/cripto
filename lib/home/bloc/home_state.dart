import 'package:equatable/equatable.dart';

import '../data/models/coin_model.dart';

class HomeState extends Equatable {
  const HomeState({
    this.items = const [],
    this.filteredItems = const [],
    this.isLoading = false,
  });

  final List<CoinModel> items;
  final List<CoinModel> filteredItems;
  final bool isLoading;

  HomeState copyWith({
    List<CoinModel>? items,
    List<CoinModel>? filteredItems,
    bool? isLoading,
  }) {
    return HomeState(
      items: items ?? this.items,
      filteredItems: filteredItems ?? this.filteredItems,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [items, filteredItems, isLoading];
}
