import 'package:equatable/equatable.dart';

import '../data/models/coin_model.dart';

class HomeState extends Equatable {
  const HomeState({
    this.items = const [],
    this.filteredItems = const [],
    this.isLoading = false,
    this.isLoggedIn = false,
  });

  final List<CoinModel> items;
  final List<CoinModel> filteredItems;
  final bool isLoading;
  final bool isLoggedIn;

  HomeState copyWith({
    List<CoinModel>? items,
    List<CoinModel>? filteredItems,
    bool? isLoading,
    bool? isLoggedIn,
  }) {
    return HomeState(
      items: items ?? this.items,
      filteredItems: filteredItems ?? this.filteredItems,
      isLoading: isLoading ?? this.isLoading,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
    );
  }

  @override
  List<Object?> get props => [items, filteredItems, isLoading, isLoggedIn];
}
