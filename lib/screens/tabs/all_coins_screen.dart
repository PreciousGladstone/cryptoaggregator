import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:kingcrpt/model/coingeckomodel.dart';
import 'package:kingcrpt/provider/market_provider.dart';
import 'package:kingcrpt/util/custom_List_Tile.dart';
import 'package:provider/provider.dart';

class AllCoinsScreen extends StatefulWidget {
  const AllCoinsScreen({super.key});

  @override
  State<AllCoinsScreen> createState() => _AllCoinsScreenState();
}

class _AllCoinsScreenState extends State<AllCoinsScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final marketProvider = Provider.of<MarketProvider>(
        context,
        listen: false,
      );
      marketProvider.startAutoRefresh();
    });
  }

  @override
  void dispose() {
    Provider.of<MarketProvider>(context, listen: false).stopAutoRefresh();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true; // keeps tab state aliv

  // Helper function to convert sparkline to FlSpot
  List<FlSpot> _getSparklineSpots(CoinData coin) {
    return coin.sparkline.asMap().entries.map((entry) {
      final index = entry.key.toDouble();
      final price = entry.value;
      return FlSpot(index, price);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final market = Provider.of<MarketProvider>(context);
    final coinsToShow = market.filteredCoins;

    

    return market.isLoading && market.coins.isEmpty
        ? const Center(child: CircularProgressIndicator(color: Colors.amber))
        : RefreshIndicator(
            color: Theme.of(context).colorScheme.primary,
            backgroundColor: Theme.of(context).colorScheme.surface,
            onRefresh: () => market.fetchData(useCache: false),
            child: ListView.builder(
              padding: EdgeInsets.only(top: 8),
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: coinsToShow.length,
              itemBuilder: (context, index) {
                final coin = coinsToShow[index];
                final isUp = (coin.priceChangePercentage24H ?? 0) >= 0;

                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),

                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(
                          context,
                        ).colorScheme.onSecondary.withOpacity(0.1),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: CustomListTile(
                    imagepath: coin.image,
                    coinName: coin.name,
                    coinSymbol: coin.symbol.toUpperCase(),
                    spots: _getSparklineSpots(coin),
                    color: isUp ? Color(0xFF21BF73) : Color(0xFFD90429),
                    priceChange24H:
                        "${coin.priceChangePercentage24H?.toStringAsFixed(2) ?? 0}%",
                    currentPrice: "\$${coin.currentPrice.toStringAsFixed(2)}",
                    coin: coin,
                  ),
                );
              },
            ),
          );
  }
}
