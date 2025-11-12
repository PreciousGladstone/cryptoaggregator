// To parse this JSON data, do:
//     final posts = postFromJson(jsonString);

import 'dart:convert';

List<CoinData> postFromJson(String str) =>
    List<CoinData>.from(json.decode(str).map((x) => CoinData.fromJson(x)));

String postToJson(List<CoinData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CoinData {
  final String id;
  final String symbol;
  final String name;
  final String image;
  final double currentPrice;
  final double? marketCap;
  final int? marketCapRank;
  final double? fullyDilutedValuation;
  final double? totalVolume;
  final double? high24H;
  final double? low24H;
  final double? priceChange24H;
  final double? priceChangePercentage24H;
  final double? marketCapChange24H;
  final double? marketCapChangePercentage24H;
  final double? circulatingSupply;
  final double? totalSupply;
  final double? maxSupply;
  final double? ath;
  final double? athChangePercentage;
  final DateTime? athDate;
  final double? atl;
  final double? atlChangePercentage;
  final DateTime? atlDate;
  final Roi? roi;
  final DateTime? lastUpdated;
  final List<double> sparkline;

  CoinData({
    required this.sparkline,
    required this.id,
    required this.symbol,
    required this.name,
    required this.image,
    required this.currentPrice,
    this.marketCap,
    this.marketCapRank,
    this.fullyDilutedValuation,
    this.totalVolume,
    this.high24H,
    this.low24H,
    this.priceChange24H,
    this.priceChangePercentage24H,
    this.marketCapChange24H,
    this.marketCapChangePercentage24H,
    this.circulatingSupply,
    this.totalSupply,
    this.maxSupply,
    this.ath,
    this.athChangePercentage,
    this.athDate,
    this.atl,
    this.atlChangePercentage,
    this.atlDate,
    this.roi,
    this.lastUpdated,
  });

  factory CoinData.fromJson(Map<String, dynamic> json) => CoinData(
        id: json["id"] ?? '',
        symbol: json["symbol"] ?? '',
        name: json["name"] ?? '',
        image: json["image"] ?? '',
        currentPrice: (json["current_price"] ?? 0).toDouble(),
        marketCap: (json["market_cap"] ?? 0).toDouble(),
        marketCapRank: json["market_cap_rank"],
        fullyDilutedValuation: json["fully_diluted_valuation"] == null
            ? null
            : (json["fully_diluted_valuation"]).toDouble(),
        totalVolume: (json["total_volume"] ?? 0).toDouble(),
        high24H: (json["high_24h"] ?? 0).toDouble(),
        low24H: (json["low_24h"] ?? 0).toDouble(),
        priceChange24H: (json["price_change_24h"] ?? 0).toDouble(),
        priceChangePercentage24H:
            (json["price_change_percentage_24h"] ?? 0).toDouble(),
        marketCapChange24H: (json["market_cap_change_24h"] ?? 0).toDouble(),
        marketCapChangePercentage24H:
            (json["market_cap_change_percentage_24h"] ?? 0).toDouble(),
        circulatingSupply: (json["circulating_supply"] ?? 0).toDouble(),
        totalSupply: (json["total_supply"] ?? 0).toDouble(),
        maxSupply: json["max_supply"] == null
            ? null
            : (json["max_supply"]).toDouble(),
        ath: (json["ath"] ?? 0).toDouble(),
        athChangePercentage: (json["ath_change_percentage"] ?? 0).toDouble(),
        athDate:
            json["ath_date"] == null ? null : DateTime.parse(json["ath_date"]),
        atl: (json["atl"] ?? 0).toDouble(),
        atlChangePercentage: (json["atl_change_percentage"] ?? 0).toDouble(),
        atlDate:
            json["atl_date"] == null ? null : DateTime.parse(json["atl_date"]),
        roi: json["roi"] == null ? null : Roi.fromJson(json["roi"]),
        lastUpdated: json["last_updated"] == null
            ? null
            : DateTime.parse(json["last_updated"]),
        sparkline: (json['sparkline_in_7d']?['price'] as List<dynamic>?)
              ?.map((e) => (e as num).toDouble())
              .toList() ??
          [], // default empty list if null
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "symbol": symbol,
        "name": name,
        "image": image,
        "current_price": currentPrice,
        "market_cap": marketCap,
        "market_cap_rank": marketCapRank,
        "fully_diluted_valuation": fullyDilutedValuation,
        "total_volume": totalVolume,
        "high_24h": high24H,
        "low_24h": low24H,
        "price_change_24h": priceChange24H,
        "price_change_percentage_24h": priceChangePercentage24H,
        "market_cap_change_24h": marketCapChange24H,
        "market_cap_change_percentage_24h": marketCapChangePercentage24H,
        "circulating_supply": circulatingSupply,
        "total_supply": totalSupply,
        "max_supply": maxSupply,
        "ath": ath,
        "ath_change_percentage": athChangePercentage,
        "ath_date": athDate?.toIso8601String(),
        "atl": atl,
        "atl_change_percentage": atlChangePercentage,
        "atl_date": atlDate?.toIso8601String(),
        "roi": roi?.toJson(),
        "last_updated": lastUpdated?.toIso8601String(),
        'sparkline_in_7d': {'price': sparkline},
      };
}

class Roi {
  final double times;
  final String currency;
  final double percentage;

  Roi({
    required this.times,
    required this.currency,
    required this.percentage,
  });

  factory Roi.fromJson(Map<String, dynamic> json) => Roi(
        times: (json["times"] ?? 0).toDouble(),
        currency: json["currency"] ?? '',
        percentage: (json["percentage"] ?? 0).toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "times": times,
        "currency": currency,
        "percentage": percentage,
      };
}