import 'package:equatable/equatable.dart';

class CoinModel extends Equatable {
  const CoinModel({
    required this.id,
    required this.name,
    required this.symbol,
    required this.image,
    required this.currentPrice,
    required this.marketCap,//
    required this.marketCapRank,
    required this.fullyDilutedValuation,//
    required this.totalVolume,//Объём торгов за 24 часа
    required this.high24h,
    required this.low24h,
    required this.priceChange24h,
    required this.priceChangePercentage24h,//Рост/падение в %
    required this.marketCapChange24h, //
    required this.marketCapChangePercentage24h,
    required this.circulatingSupply,//
    required this.totalSupply,//
    required this.maxSupply,//
    required this.ath,//самая высокая цена за всю историю монеты
    required this.athChangePercentage,
    required this.athDate,
    required this.atl,//на сколько сейчас цена ниже ATH
    required this.atlChangePercentage,
    required this.atlDate,
    required this.roi,//
    required this.lastUpdated,
  });

  factory CoinModel.fromJson(Map<String, dynamic> json) {
    return CoinModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      symbol: json['symbol'] as String? ?? '',
      image: json['image'] as String? ?? '',
      currentPrice: (json['current_price'] as num?)?.toDouble() ?? 0.0,
      marketCap: (json['market_cap'] as num?)?.toInt() ?? 0,
      marketCapRank: (json['market_cap_rank'] as num?)?.toInt() ?? 0,
      fullyDilutedValuation: (json['fully_diluted_valuation'] as num?)
          ?.toInt(),
      totalVolume: (json['total_volume'] as num?)?.toInt() ?? 0,
      high24h: (json['high_24h'] as num?)?.toDouble(),
      low24h: (json['low_24h'] as num?)?.toDouble(),
      priceChange24h: (json['price_change_24h'] as num?)?.toDouble(),
      priceChangePercentage24h:
          (json['price_change_percentage_24h'] as num?)?.toDouble(),
      marketCapChange24h: (json['market_cap_change_24h'] as num?)?.toDouble(),
      marketCapChangePercentage24h:
          (json['market_cap_change_percentage_24h'] as num?)?.toDouble(),
      circulatingSupply: (json['circulating_supply'] as num?)?.toDouble(),
      totalSupply: (json['total_supply'] as num?)?.toDouble(),
      maxSupply: (json['max_supply'] as num?)?.toDouble(),
      ath: (json['ath'] as num?)?.toDouble(),
      athChangePercentage: (json['ath_change_percentage'] as num?)?.toDouble(),
      athDate: DateTime.tryParse(json['ath_date'] as String? ?? ''),
      atl: (json['atl'] as num?)?.toDouble(),
      atlChangePercentage: (json['atl_change_percentage'] as num?)?.toDouble(),
      atlDate: DateTime.tryParse(json['atl_date'] as String? ?? ''),
      roi: json['roi'] == null
          ? null
          : CoinRoiModel.fromJson(json['roi'] as Map<String, dynamic>),
      lastUpdated: DateTime.tryParse(json['last_updated'] as String? ?? ''),
    );
  }

  final String id;
  final String name;
  final String symbol;
  final String image;
  final double currentPrice;
  final int marketCap;
  final int marketCapRank;
  final int? fullyDilutedValuation;
  final int totalVolume;
  final double? high24h;
  final double? low24h;
  final double? priceChange24h;
  final double? priceChangePercentage24h;
  final double? marketCapChange24h;
  final double? marketCapChangePercentage24h;
  final double? circulatingSupply;
  final double? totalSupply;
  final double? maxSupply;
  final double? ath;
  final double? athChangePercentage;
  final DateTime? athDate;
  final double? atl;
  final double? atlChangePercentage;
  final DateTime? atlDate;
  final CoinRoiModel? roi;
  final DateTime? lastUpdated;

  CoinModel copyWith({
    String? id,
    String? name,
    String? symbol,
    String? image,
    double? currentPrice,
    int? marketCap,
    int? marketCapRank,
    int? fullyDilutedValuation,
    int? totalVolume,
    double? high24h,
    double? low24h,
    double? priceChange24h,
    double? priceChangePercentage24h,
    double? marketCapChange24h,
    double? marketCapChangePercentage24h,
    double? circulatingSupply,
    double? totalSupply,
    double? maxSupply,
    double? ath,
    double? athChangePercentage,
    DateTime? athDate,
    double? atl,
    double? atlChangePercentage,
    DateTime? atlDate,
    CoinRoiModel? roi,
    DateTime? lastUpdated,
  }) {
    return CoinModel(
      id: id ?? this.id,
      name: name ?? this.name,
      symbol: symbol ?? this.symbol,
      image: image ?? this.image,
      currentPrice: currentPrice ?? this.currentPrice,
      marketCap: marketCap ?? this.marketCap,
      marketCapRank: marketCapRank ?? this.marketCapRank,
      fullyDilutedValuation:
          fullyDilutedValuation ?? this.fullyDilutedValuation,
      totalVolume: totalVolume ?? this.totalVolume,
      high24h: high24h ?? this.high24h,
      low24h: low24h ?? this.low24h,
      priceChange24h: priceChange24h ?? this.priceChange24h,
      priceChangePercentage24h:
          priceChangePercentage24h ?? this.priceChangePercentage24h,
      marketCapChange24h: marketCapChange24h ?? this.marketCapChange24h,
      marketCapChangePercentage24h:
          marketCapChangePercentage24h ?? this.marketCapChangePercentage24h,
      circulatingSupply: circulatingSupply ?? this.circulatingSupply,
      totalSupply: totalSupply ?? this.totalSupply,
      maxSupply: maxSupply ?? this.maxSupply,
      ath: ath ?? this.ath,
      athChangePercentage: athChangePercentage ?? this.athChangePercentage,
      athDate: athDate ?? this.athDate,
      atl: atl ?? this.atl,
      atlChangePercentage: atlChangePercentage ?? this.atlChangePercentage,
      atlDate: atlDate ?? this.atlDate,
      roi: roi ?? this.roi,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    symbol,
    image,
    currentPrice,
    marketCap,
    marketCapRank,
    fullyDilutedValuation,
    totalVolume,
    high24h,
    low24h,
    priceChange24h,
    priceChangePercentage24h,
    marketCapChange24h,
    marketCapChangePercentage24h,
    circulatingSupply,
    totalSupply,
    maxSupply,
    ath,
    athChangePercentage,
    athDate,
    atl,
    atlChangePercentage,
    atlDate,
    roi,
    lastUpdated,
  ];
}

class CoinRoiModel extends Equatable {
  const CoinRoiModel({
    required this.times,
    required this.currency,
    required this.percentage,
  });

  factory CoinRoiModel.fromJson(Map<String, dynamic> json) {
    return CoinRoiModel(
      times: (json['times'] as num?)?.toDouble() ?? 0.0,
      currency: json['currency'] as String? ?? '',
      percentage: (json['percentage'] as num?)?.toDouble() ?? 0.0,
    );
  }

  final double times;
  final String currency;
  final double percentage;

  CoinRoiModel copyWith({
    double? times,
    String? currency,
    double? percentage,
  }) {
    return CoinRoiModel(
      times: times ?? this.times,
      currency: currency ?? this.currency,
      percentage: percentage ?? this.percentage,
    );
  }

  @override
  List<Object?> get props => [times, currency, percentage];
}
