import 'dart:convert';
import 'package:http/http.dart' as http;

class CoinGeckoFetchOhlc {
  // Fetch OHLC data for a coin
  static Future<List<List<double>>> fetchOHLC(String id, int days) async {
    final url =
        "https://api.coingecko.com/api/v3/coins/$id/ohlc?vs_currency=usd&days=$days";

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      // Each item: [timestamp, open, high, low, close]
      return data.map<List<double>>((e) => List<double>.from(e)).toList();
    } else {
      throw Exception("Failed to fetch OHLC");
    }
  }
}