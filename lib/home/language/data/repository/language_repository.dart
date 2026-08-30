import 'dart:async';

import 'package:injectable/injectable.dart';

import '../api/language_api.dart';
import '../models/language.dart';

@LazySingleton(as: LanguageRepositoryI)
class LanguageRepository extends LanguageRepositoryI {
  LanguageRepository({required LanguageApiI api})
    : _api = api,
      _currentLanguage = api.getLanguage();

  final LanguageApiI _api;
  Language _currentLanguage;
  final _languageController = StreamController<Language>.broadcast();

  @override
  Language get currentLanguage => _currentLanguage;

  @override
  Stream<Language> get languageStream => _languageController.stream;

  @override
  Future<void> changeLanguage(Language language) async {
    _currentLanguage = language;
    await _api.saveLanguage(language);
    _languageController.add(language);
  }
}

abstract class LanguageRepositoryI {
  Language get currentLanguage;

  Stream<Language> get languageStream;

  Future<void> changeLanguage(Language language);
}
