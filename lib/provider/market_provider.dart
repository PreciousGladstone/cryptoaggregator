import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kingcrpt/model/coingeckomodel.dart';
import 'package:kingcrpt/services/coin_gecko_service.dart';

class MarketProvider extends ChangeNotifier{
  final CoinGeckoService _service = CoinGeckoService();
  List<CoinData> _coins = [];
  bool _isLoading = false;
  bool _isSearching = false;
  Timer? _timer;

  bool get isSearching => _isSearching;

  String _query = "";

  String get query => _query;


  List<CoinData> get coins => _coins;
  bool get isLoading => _isLoading;

  //  NEW: Favourites tracking
  final Box _cacheBox = Hive.box('Favourite');
  Set<String> _favourites = {};

  Set<String> get favourites => _favourites;

  // Initialize favorites
  Future<void> loadFavorites() async {
    final favList = _cacheBox.get('favourites', defaultValue: []);
    _favourites = Set<String>.from(favList);
    notifyListeners();
  }

  // Toggle favourite coin by id
  void toggleFavourite(String coinId) {
    if (_favourites.contains(coinId)) {
      _favourites.remove(coinId);
    } else {
      _favourites.add(coinId);
    }
    _cacheBox.put('favourites', _favourites.toList());
    notifyListeners();
  }

  bool isFavourite(String coinId) => _favourites.contains(coinId);

  List<CoinData> get favouriteCoins =>
      _coins.where((c) => _favourites.contains(c.id)).toList();


  

  Future<void> fetchData({bool useCache = true}) async{
    _isLoading = true;
    
    notifyListeners();

    //loading the cache data 
    final box = Hive.box('Market Cache');
    if(useCache && box.containsKey('coins')){
      try{
        final cached = box.get('coins');
        final decoded = jsonDecode(cached) as List<dynamic>;
        _coins = decoded.map((e) => CoinData.fromJson(e)).toList();
        
      } catch(e){
        debugPrint("Cache Parse error: $e");
      }
    }

    //fetching live data
    try{
      
      final liveData = await _service.getMarketData();
      _coins = liveData;
      
      //save to cache 
      final encoded = jsonEncode(_coins.map((e)=> e.toJson()).toList());
      await box.put('coins', encoded);
      
    } catch(e){
      debugPrint('Error fetching coins: $e');
    } finally {
      _isLoading = false;
      
      notifyListeners();
    }


  }

  //helper function to get the top gainers
  List<CoinData> get topGainers {
  final sorted = List<CoinData>.from(_coins);
  sorted.sort((a, b) =>
      (b.priceChangePercentage24H ?? 0).compareTo(a.priceChangePercentage24H ?? 0));
  return sorted.take(100).toList();
}

//helper function to get the top loser
List<CoinData> get topLosers {
  final sorted = List<CoinData>.from(_coins);
  sorted.sort((a, b) =>
      (a.priceChangePercentage24H ?? 0).compareTo(b.priceChangePercentage24H ?? 0));
  return sorted.take(100).toList();
}

  void startAutoRefresh(){
    
    
    _timer = Timer.periodic(Duration(seconds: 20), (timer)async{
      if (_isLoading) return;
    
    _isLoading = true;
    try {
      await fetchData(useCache: false);
    } catch (e) {
      debugPrint("❌ Auto-refresh error: $e");
    } finally {
      _isLoading = false;
    }
     });
  }
  List<CoinData> get filteredCoins {
  if (_query.isEmpty) return _coins;
  final lowerQuery = _query.toLowerCase();
  return _coins
      .where((coin) =>
          coin.name.toLowerCase().contains(lowerQuery) ||
          coin.symbol.toLowerCase().contains(lowerQuery))
      .toList();
}

List<CoinData> get filteredFavourites {
  if (_query.isEmpty) return favouriteCoins;
  return favouriteCoins
      .where((c) =>
          c.name.toLowerCase().contains(_query.toLowerCase()) ||
          c.symbol.toLowerCase().contains(_query.toLowerCase()))
      .toList();
}
List<CoinData> get filteredLosers {
  if (_query.isEmpty) return topLosers;
  return topLosers.where((c) =>
      c.name.toLowerCase().contains(_query.toLowerCase()) ||
      c.symbol.toLowerCase().contains(_query.toLowerCase())
  ).toList();
}
List<CoinData> get filteredGainers {
  if (_query.isEmpty) return topGainers;
  return topGainers.where((c) =>
      c.name.toLowerCase().contains(_query.toLowerCase()) ||
      c.symbol.toLowerCase().contains(_query.toLowerCase())
  ).toList();
}



  void toggleSearch() {
    _isSearching = !_isSearching;
    if (!_isSearching) _query = "";
    notifyListeners();
  }

  void setQuery(String value) {
    _query = value;
    notifyListeners();
  }

  void stopAutoRefresh(){
    _timer?.cancel();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  


}