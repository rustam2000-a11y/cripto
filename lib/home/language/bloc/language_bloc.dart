import 'package:bloc_after_effect/bloc_after_effect.dart';
import 'package:injectable/injectable.dart';

import '../data/repository/language_repository.dart';
import 'language_effect.dart';
import 'language_event.dart';
import 'language_state.dart';

@injectable
class LanguageBloc extends EffectBloc<LanguageEvent, LanguageState, LanguageEffect> {
  LanguageBloc({required LanguageRepositoryI languageRepository})
    : _languageRepository = languageRepository,
      super(LanguageState(selectedLanguage: languageRepository.currentLanguage)) {
    on<SelectLanguageEvent>((event, emit) {
      emit(state.copyWith(selectedLanguage: event.language));
    });
    on<ApplyLanguageEvent>((event, emit)  {
       _languageRepository.changeLanguage(state.selectedLanguage);
      emitEffect(const LanguageApplied());
    });
  }

  final LanguageRepositoryI _languageRepository;
}
