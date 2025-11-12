import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:kingcrpt/component/detailed%20screen/detailed_row.dart';
import 'package:kingcrpt/model/coingeckomodel.dart';
import 'package:kingcrpt/provider/chart_type_provider.dart';
import 'package:kingcrpt/provider/market_provider.dart';
import 'package:kingcrpt/util/interval_button.dart';
import 'package:kingcrpt/util/jsfolder/web_view_chart.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class CoinDetailScreen extends StatefulWidget {
  final CoinData coin;
  const CoinDetailScreen({super.key, required this.coin});

  @override
  State<CoinDetailScreen> createState() => _CoinDetailScreenState();
}

class _CoinDetailScreenState extends State<CoinDetailScreen> {
  List<FlSpot> getSparklineSpots() {
    return widget.coin.sparkline
        .asMap()
        .entries
        .map((e) => FlSpot(e.key.toDouble(), e.value))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final coin = widget.coin;
    final market = Provider.of<MarketProvider>(context);
    final chartProvider = Provider.of<ChartProvider>(context);
    final isFavourite = market.isFavourite(coin.id);
    final isUp = (coin.priceChangePercentage24H ?? 0) >= 0;
    
    String formatCurrency(num? value) {
      final formatter = NumberFormat.compactCurrency(symbol: '\$');
      return formatter.format(value ?? 0);
    }

    

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Row(
          children: [
            Image.network(coin.image, width: 24, height: 24),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                coin.name,
                overflow: TextOverflow.fade,
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge!.copyWith(fontSize: 16),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(
              isFavourite ? Icons.star : Icons.star_border,
              color: isFavourite ? Colors.amber[600] : Colors.black,
            ),
            onPressed: () => market.toggleFavourite(coin.id),
          ),
        ],
      ),
      body: Column(
        children: [
          // Price info
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Text(
                  "\$${coin.currentPrice.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  "${coin.priceChange24H?.toStringAsFixed(2) ?? 0}",
                  style: TextStyle(
                    color: isUp ? Colors.green : Colors.red,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  "(${coin.priceChangePercentage24H?.toStringAsFixed(2) ?? 0}%)",
                  style: TextStyle(
                    color: isUp ? Colors.green : Colors.red,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // TradingView Chart
          SizedBox(
            height: 300,
            width: MediaQuery.of(context).size.width,
            child: TradingViewChart(
              symbol: coin.symbol,
              isLightMode: Theme.of(context).brightness == Brightness.light,
              interval: chartProvider.selectedInterval,
            ),
          ),

          const SizedBox(height: 20),

          // Interval Buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                IntervalButton(label: "1m", value: "1"),
                SizedBox(width: 8),
                IntervalButton(label: "5m", value: "5"),
                SizedBox(width: 8),
                IntervalButton(label: "1H", value: "60"),
                SizedBox(width: 8),
                IntervalButton(label: "1D", value: "D"),
                SizedBox(width: 8),
                IntervalButton(label: "1W", value: "1W"),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Additional coin details
          Expanded(
            child: ListView(
              children: [
                ClipRRect(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Theme.of(context).colorScheme.surface,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          offset: Offset(0, 2),
                          blurRadius: 4
                        )
                      ]
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16.0,
                        horizontal: 5,
                      ),
                      child: IntrinsicHeight(
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  DetailedRow(
                                    title: "Market Cap",
                                    value: formatCurrency(coin.marketCap),
                                  ),
                                  DetailedRow(
                                    title: "Volumn 24",
                                    value: formatCurrency(coin.totalVolume),
                                  ),
                                  DetailedRow(
                                    title: "Max Supply",
                                    value:
                                        "${NumberFormat.decimalPattern().format(coin.maxSupply ?? 0)} ${coin.symbol.toUpperCase()}",
                                  ),
                                  DetailedRow(
                                    title: "All Time High",
                                    value: "\$${NumberFormat.decimalPattern().format(coin.ath ?? 0)}",
                                  ),
                                  DetailedRow(
                                    title: "All Time Low",
                                    value: "\$${NumberFormat.decimalPattern().format(coin.atl ?? 0)}",
                                  ),
                                ],
                              ),
                            ),
                            VerticalDivider(
                              color: Theme.of(
                                context,
                              ).colorScheme.secondary.withOpacity(0.25),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  DetailedRow(
                                    title: "Fully Diluted Market Cap",
                                    value: formatCurrency(
                                      coin.fullyDilutedValuation,
                                    ),
                                  ),
                                  DetailedRow(
                                    title: "Circulating Supply",
                                    value:
                                        "${NumberFormat.decimalPattern().format(coin.circulatingSupply ?? 0)} ${coin.symbol.toUpperCase()}",
                                  ),
                                  DetailedRow(
                                    title: "Total Supply",
                                    value:
                                        "${NumberFormat.decimalPattern().format(coin.totalSupply ?? 0)} ${coin.symbol.toUpperCase()}",
                                  ),
                                  DetailedRow(
                                    title: "Rank",
                                    value: "#${coin.marketCapRank ?? '-'}",
                                  ),
                                  
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
