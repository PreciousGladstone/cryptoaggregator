import 'package:kingcrpt/model/coingeckomodel.dart';
import 'package:http/http.dart' as http;

class CoinGeckoService {
  final String _baseUrl = "https://api.coingecko.com/api/v3";

  Future<List<CoinData>> getMarketData({String vsCurrency = "usd"}) async{
    var client = http.Client();
    
    var uri = Uri.parse("$_baseUrl/coins/markets?vs_currency=$vsCurrency&order=market_cap_desc&per_page=200&page=1&sparkline=true");
    var responds = await client.get(uri);

    if(responds.statusCode == 200){
      return postFromJson(responds.body);

    }else {
      throw Exception("Failed to fetch Data from coinGecko");
    }

  }
}