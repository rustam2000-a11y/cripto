import '../data/models/language.dart';

abstract class LanguageEvent {
  const LanguageEvent();
}

class SelectLanguageEvent extends LanguageEvent {
  const SelectLanguageEvent(this.language);

  final Language language;
}

class ApplyLanguageEvent extends LanguageEvent {
  const ApplyLanguageEvent();
}
