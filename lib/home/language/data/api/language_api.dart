import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/language.dart';

@Injectable(as: LanguageApiI)
class LanguageApi extends LanguageApiI {
  LanguageApi(this._preferences);

  final SharedPreferences _preferences;

  static const _languageCodeKey = 'language_code';

  @override
  Language getLanguage() {
    final code = _preferences.getString(_languageCodeKey);
    if (code == null) return Language.english;
    return Language.fromCode(code);
  }

  @override
  Future<void> saveLanguage(Language language) {
    return _preferences.setString(_languageCodeKey, language.code);
  }
}

abstract class LanguageApiI {
  Language getLanguage();

  Future<void> saveLanguage(Language language);
}
