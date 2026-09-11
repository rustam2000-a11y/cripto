import 'package:bloc_after_effect/bloc_after_effect.dart';
import 'package:injectable/injectable.dart';

import '../data/repository/insight_repository.dart';
import 'insight_effect.dart';
import 'insight_event.dart';
import 'insight_state.dart';

@injectable
class InsightBloc
    extends EffectBloc<InsightEvent, InsightState, InsightEffect> {
  InsightBloc({required InsightRepositoryI insightRepository})
    : _insightRepository = insightRepository,
      super(const InsightState()) {
    on<LoadInsightsEvent>((event, emit) {
      if (state.isLoading) return;
      _loadInsights();
    });
    on<InsightLoadingEvent>((event, emit) {
      emit(state.copyWith(isLoading: event.isLoading, clearError: true));
    });
    on<InsightsLoadedEvent>((event, emit) {
      emit(state.copyWith(insights: event.insights, isLoading: false));
    });
    on<InsightLoadFailedEvent>((event, emit) {
      emit(state.copyWith(isLoading: false, errorMessage: event.message));
    });
  }

  final InsightRepositoryI _insightRepository;

  Future<void> _loadInsights() async {
    add(const InsightLoadingEvent(isLoading: true));
    try {
      final insights = await _insightRepository.loadInsights();
      add(InsightsLoadedEvent(insights: insights));
    } catch (e) {
      final message = _describeError(e);
      emitEffect(InsightShowError(message));
      add(InsightLoadFailedEvent(message: message));
    }
  }

  String _describeError(Object error) {
    if (error is StateError) return error.message;
    return error.toString();
  }
}
