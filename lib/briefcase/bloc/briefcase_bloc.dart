import 'dart:async';

import 'package:bloc_after_effect/bloc_after_effect.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../core/models/user_model.dart';
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

  void _watchUserCoins() {
    _coinsSubscription?.cancel();
    _coinsSubscription = Rx.combineLatest2<List<CoinModel>, UserModel?, List<CoinModel>>(
      _coinRepository.watchCoins(),
      _registrationRepository.watchCurrentUserProfile(),
      (coins, userProfile) {
        final coinIds = userProfile?.coinIds ?? const [];
        return coins.where((coin) => coinIds.contains(coin.id)).toList();
      },
    ).listen((userCoins) {
      add(BriefcaseCoinsLoadedEvent(coins: userCoins));
    });
  }

  @override
  Future<void> close() {
    _coinsSubscription?.cancel();
    return super.close();
  }
}
