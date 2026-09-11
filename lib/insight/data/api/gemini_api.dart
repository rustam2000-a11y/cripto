import 'dart:async';
import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:injectable/injectable.dart';

import '../../../home/data/models/coin_model.dart';

@Injectable(as: GeminiApiI)
class GeminiApi extends GeminiApiI {
  GeminiApi() : _model = GenerativeModel(
         model: _modelName,
         apiKey: _apiKey,
         generationConfig: GenerationConfig(
           responseMimeType: 'application/json',
           responseSchema: Schema.array(
             items: Schema.object(
               properties: {
                 'id': Schema.string(
                   description: 'id монеты, точно как в запросе',
                 ),
                 'analysis': Schema.string(
                   description: 'Аналитический текст на русском, 2-3 предложения',
                 ),
               },
               requiredProperties: ['id', 'analysis'],
             ),
           ),
         ),
       );

  // 'flash' модель дневного лимита free-tier хватает всего на ~2 открытия
  // экрана (по 10 запросов на 20/день); 'flash-lite' даёт заметно больше
  // квоты и достаточна для короткого аналитического текста.
  static const _modelName = 'gemini-3.1-flash-lite';
  static const _timeout = Duration(seconds: 30);
  static const _overloadedRetryDelays = [Duration(seconds: 2), Duration(seconds: 5)];

  static String get _apiKey {
    final key = dotenv.env['GEMINI_API_KEY'];
    if (key == null || key.isEmpty) {
      throw StateError('GEMINI_API_KEY не найден в .env файле');
    }
    return key;
  }

  final GenerativeModel _model;

  @override
  Future<Map<String, String>> analyzeCoins({
    required List<CoinModel> coins,
    required Map<String, double> average14dPrices,
  }) async {
    if (coins.isEmpty) return {};
    for (var attempt = 0; ; attempt++) {
      try {
        final response = await _model
            .generateContent([
              Content.text(
                _buildPrompt(coins: coins, average14dPrices: average14dPrices),
              ),
            ])
            .timeout(_timeout);
        final text = response.text?.trim();
        if (text == null || text.isEmpty) {
          throw StateError('ИИ не вернул анализ');
        }
        return _parseResponse(text);
      } on TimeoutException {
        throw StateError('Сервис ИИ не отвечает, попробуйте позже');
      } on GenerativeAIException catch (e) {
        final isOverloaded = e.message.contains('503');
        if (isOverloaded && attempt < _overloadedRetryDelays.length) {
          await Future.delayed(_overloadedRetryDelays[attempt]);
          continue;
        }
        if (e.message.toLowerCase().contains('quota')) {
          throw StateError(
            'Дневной лимит запросов к ИИ исчерпан, попробуйте завтра',
          );
        }
        throw StateError(
          isOverloaded
              ? 'ИИ сейчас перегружен, попробуйте позже'
              : 'Не удалось получить ответ от ИИ: ${e.message}',
        );
      }
    }
  }

  Map<String, String> _parseResponse(String text) {
    final List<dynamic> decoded;
    try {
      decoded = jsonDecode(text) as List<dynamic>;
    } on FormatException {
      throw StateError('Не удалось разобрать ответ ИИ');
    }
    return {
      for (final item in decoded)
        if (item is Map<String, dynamic> &&
            item['id'] is String &&
            item['analysis'] is String)
          item['id'] as String: (item['analysis'] as String).trim(),
    };
  }

  String _buildPrompt({
    required List<CoinModel> coins,
    required Map<String, double> average14dPrices,
  }) {
    final coinsBlock = coins
        .map((coin) {
          final average14dPrice = average14dPrices[coin.id] ?? coin.currentPrice;
          return '''
- id: ${coin.id}
  Название: ${coin.name} (${coin.symbol.toUpperCase()})
  Текущая цена: \$${coin.currentPrice}
  Средняя цена за 14 дней: \$${average14dPrice.toStringAsFixed(2)}
  Изменение цены за 24 часа: ${coin.priceChangePercentage24h?.toStringAsFixed(2) ?? '—'}%
  Максимум за 24 часа: ${coin.high24h ?? '—'}
  Минимум за 24 часа: ${coin.low24h ?? '—'}
  Исторический максимум (ATH): ${coin.ath ?? '—'}
  Изменение капитализации за 24 часа: ${coin.marketCapChangePercentage24h?.toStringAsFixed(2) ?? '—'}%''';
        })
        .join('\n');

    return '''
Ты — финансовый аналитик в мобильном крипто-приложении. Для КАЖДОЙ из монет ниже напиши короткий аналитический текст: 2-3 предложения, без заголовка, без списков и markdown-разметки, на русском языке, в нейтральном аналитическом тоне. Не давай прямых советов "покупать"/"продавать". Опиши положение цены относительно средней за 14 дней, скорость движения (моментум) и риск перегрева/коррекции.

Пример нужного стиля (про другую монету):
"Биткоин сейчас торгуется выше своей средней цены за последние 14 дней, что говорит о восходящем тренде. Однако скорость роста высокая — это может означать, что актив «перегрет», и в ближайшее время возможна коррекция или пауза в росте, прежде чем движение продолжится."

Монеты:
$coinsBlock

Верни результат строго в виде JSON-массива объектов с полями "id" (совпадает с id монеты выше) и "analysis" (сам аналитический текст) — по одному объекту на каждую монету, без вступлений и пояснений.
''';
  }
}

abstract class GeminiApiI {
  Future<Map<String, String>> analyzeCoins({
    required List<CoinModel> coins,
    required Map<String, double> average14dPrices,
  });
}
