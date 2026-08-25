import 'dart:async';

import 'package:bloc_after_effect/bloc_after_effect.dart';
import 'package:injectable/injectable.dart';

import '../../home/data/models/coin_model.dart';
import '../../home/data/repository/coint_rpository.dart';
import '../../registration/data/repository/registration_repository.dart';
import 'briefcase_effect.dart';
import 'briefcase_event.dart';
import 'briefcase_state.dart';

@injectable
class BriefcaseBloc extends EffectBloc<BriefcaseEvent, BriefcaseState, BriefcaseEffect> {
  BriefcaseBloc({
    required CoinRepositoryI coinRepository,
    required RegistrationRepositoryI registrationRepository,
  }) : _coinRepository = coinRepository,
       _registrationRepository = registrationRepository,
       super(const BriefcaseState()) {
    on<BriefcaseLoadingEvent>((event, emit) {
      emit(state.copyWith(isLoading: event.isLoading));
    });
    on<BriefcaseCoinsLoadedEvent>((event, emit) {
      emit(state.copyWith(coins: event.coins, isLoading: false));
    });

    init();
  }

  final CoinRepositoryI _coinRepository;
  final RegistrationRepositoryI _registrationRepository;
  StreamSubscription<List<CoinModel>>? _coinsSubscription;

  void init() {
    if (_registrationRepository.currentUser == null) {
      emitEffect(const BriefcaseNavigateToLogin());
      return;
    }
    add(const BriefcaseLoadingEvent(isLoading: true));
    _watchUserCoins();
  }

  Future<void> _watchUserCoins() async {
    final userProfile = await _registrationRepository.getCurrentUserProfile();
    final coinIds = userProfile?.coinIds ?? const [];

    _coinsSubscription?.cancel();
    _coinsSubscription = _coinRepository.watchCoins().listen((coins) {
      final userCoins = coins.where((coin) => coinIds.contains(coin.id)).toList();
      add(BriefcaseCoinsLoadedEvent(coins: userCoins));
    });
  }

  @override
  Future<void> close() {
    _coinsSubscription?.cancel();
    return super.close();
  }
}
