import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:kingcrpt/model/coingeckomodel.dart';
import 'package:kingcrpt/provider/market_provider.dart';
import 'package:kingcrpt/util/custom_List_Tile.dart';
import 'package:provider/provider.dart';

class GainersScreen extends StatelessWidget {
  const GainersScreen({super.key});


  List<FlSpot> _getSparklineSpots(CoinData coin) {
    return coin.sparkline.asMap().entries.map((entry) {
      return FlSpot(entry.key.toDouble(), entry.value);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final market = Provider.of<MarketProvider>(context);
    final gainers = market.filteredGainers;

    return market.isLoading && market.coins.isEmpty
        ? const Center(child: CircularProgressIndicator(color: Colors.amber))
        : RefreshIndicator(
            color: Theme.of(context).colorScheme.primary,
            backgroundColor: Theme.of(context).colorScheme.surface,
            onRefresh: () => market.fetchData(useCache: false),
            child: ListView.builder(
              padding: EdgeInsets.only(top: 8),
              itemCount: gainers.length,
              itemBuilder: (context, index) {
                final coin = gainers[index];
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
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: CustomListTile(
                    imagepath: coin.image,
                    coinName: coin.name,
                    coinSymbol: coin.symbol.toUpperCase(),
                    spots: _getSparklineSpots(coin),
                    color: isUp
                        ? const Color(0xFF21BF73)
                        : const Color(0xFFD90429),
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
