# Crypto Assistant

Мобильное приложение на Flutter: отслеживание криптовалют (котировки, графики), избранное/портфель («портфель»/briefcase) и AI-ассистент. Бэкенд — Firebase (Auth, Firestore, Storage), котировки — CoinGecko API.

## Стек

- **Flutter** 3.35.4 (управляется через [FVM](https://fvm.app)), Dart SDK `^3.9.0`
- **State management**: `flutter_bloc`, `provider`
- **DI**: `get_it` + `injectable` (код генерируется через `build_runner`)
- **Backend**: Firebase (`firebase_auth`, `cloud_firestore`, `firebase_storage`), Google/Apple Sign-In
- **Данные о крипте**: CoinGecko REST API (`http`), графики — `fl_chart`
- **Локализация**: `flutter_localizations` + `intl_utils` (en/ru)

## Требования

- Flutter 3.35.4 — рекомендуется ставить через [FVM](https://fvm.app), версия уже зафиксирована в `.fvmrc`
- Xcode + CocoaPods (для сборки под iOS)
- Android Studio / Android SDK (для сборки под Android), Java 11
- Аккаунт Firebase с доступом к проекту (конфиги `google-services.json` и `GoogleService-Info.plist` уже лежат в репозитории, дополнительно настраивать не нужно)

## Установка

1. Установить FVM (если ещё не установлен):
   ```bash
   dart pub global activate fvm
   ```

2. Установить нужную версию Flutter для проекта:
   ```bash
   fvm install
   ```

3. Установить зависимости:
   ```bash
   fvm flutter pub get
   ```

4. Создать файл `.env` в корне проекта (он не хранится в git) и заполнить переменные:
   ```env
   GEMINI_API_KEY=your_gemini_api_key
   ```
   Ключ спросить у тимлида/в внутреннем хранилище секретов.

5. Для iOS дополнительно поставить поды:
   ```bash
   cd ios && pod install && cd ..
   ```

## Генерация кода

Проект использует кодогенерацию для DI (`injectable`) и локализации (`intl_utils`). Сгенерированные файлы уже закоммичены, но после изменения `@injectable`-классов или `.arb`-файлов их нужно перегенерировать:

```bash
# DI (get_it/injectable)
fvm flutter pub run build_runner build --delete-conflicting-outputs

# либо в режиме наблюдения за изменениями
fvm flutter pub run build_runner watch --delete-conflicting-outputs

# локализация (после правок lib/l10n/*.arb)
fvm flutter pub run intl_utils:generate
```

## Запуск

Посмотреть доступные устройства/эмуляторы:
```bash
fvm flutter devices
```

Запустить приложение:
```bash
fvm flutter run
```

Запустить на конкретной платформе:
```bash
fvm flutter run -d ios
fvm flutter run -d android
fvm flutter run -d chrome   # web
fvm flutter run -d macos    # desktop
```

## Тесты и линт

```bash
fvm flutter analyze   # статический анализ
fvm flutter test      # unit/widget-тесты
```

## Сборка релиза

```bash
fvm flutter build apk --release        # Android APK
fvm flutter build appbundle --release  # Android App Bundle (Google Play)
fvm flutter build ios --release        # iOS (далее архивация через Xcode)
```

## Структура проекта

Фичи организованы по папкам в `lib/`, каждая — со своими `bloc`/`data`/`domain`/`widget`:

```
lib/
├── assistant/     # AI-ассистент
├── briefcase/     # портфель пользователя
├── coin_card/     # карточка монеты
├── core/          # общие UI-компоненты, модели, адаптивность (UiProvider)
├── generated/     # сгенерированные файлы локализации
├── home/          # главный экран, работа с API, языки
├── l10n/          # .arb файлы локализации (en/ru)
├── navigation/    # навигация/боттом-бар
├── presentation/  # общие константы (цвета, изображения)
├── registration/  # регистрация/логин
├── injection.dart # настройка get_it/injectable
└── main.dart      # точка входа
```

## Переменные окружения

| Переменная       | Назначение                  |
|------------------|------------------------------|
| `GEMINI_API_KEY` | Ключ для AI-ассистента (Gemini) |

Файл `.env` не должен попадать в git — храните ключи локально.
