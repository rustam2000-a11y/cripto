import 'dart:async';

import 'package:bloc_after_effect/bloc_after_effect.dart';
import 'package:injectable/injectable.dart';

import '../../registration/data/repository/registration_repository.dart';
import '../data/models/coin_model.dart';
import '../data/repository/coint_rpository.dart';
import 'home_effect.dart';
import 'home_event.dart';
import 'home_state.dart';

@injectable
class HomeBloc extends EffectBloc<HomeEvent, HomeState, HomeEffect> {
  HomeBloc({
    required CoinRepositoryI coinRepository,
    required RegistrationRepositoryI registrationRepository,
  }) : _coinRepository = coinRepository,
       _registrationRepository = registrationRepository,
       super(const HomeState()) {
    on<LoadingEvent>((event, emit) {
      emit(state.copyWith(isLoading: event.isLoading));
    });
    on<LoadItemsEvent>((event, emit) {
      emit(
        state.copyWith(
          items: event.items,
          filteredItems: event.items,
          isLoading: false,
        ),
      );
    });
    on<SearchQueryChangedEvent>((event, emit) {
      _searchCoins(event.query);
    });
    on<ChangedFilteredItemsEvent>((event, emit) {
      emit(state.copyWith(filteredItems: event.filteredItems));
    });
    on<LogOutEvent>((event, emit) {
      _logOut();
    });
    _init();
  }

  final CoinRepositoryI _coinRepository;
  final RegistrationRepositoryI _registrationRepository;
  StreamSubscription<List<CoinModel>>? _coinsSubscription;

  void _init() {
    add(LoadingEvent(isLoading: true));
    _coinsSubscription = _coinRepository.watchCoins().listen((coins) {
      add(LoadItemsEvent(items: coins));
    });
  }

  void _searchCoins(String query) {
    if (query.isEmpty) state.items;
    final lowerQuery = query.toLowerCase();
    final filter = state.items
        .where(
          (coin) =>
              coin.name.toLowerCase().contains(lowerQuery) ||
              coin.symbol.toLowerCase().contains(lowerQuery),
        )
        .toList();
    add(ChangedFilteredItemsEvent(filteredItems: filter));
  }

  void _logOut() async {
    await _registrationRepository.logout();
  }

  @override
  Future<void> close() {
    _coinsSubscription?.cancel();
    return super.close();
  }
}
