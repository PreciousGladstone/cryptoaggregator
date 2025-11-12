import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:kingcrpt/model/coingeckomodel.dart';
import 'package:kingcrpt/screens/coin_detailed_screen.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.imagepath,
    required this.coinName,
    required this.coinSymbol,
    required this.spots,
    required this.color,
    required this.priceChange24H,
    required this.currentPrice,
    required this.coin,
  });

  final String imagepath;
  final String coinName;
  final String coinSymbol;
  final List<FlSpot> spots;
  final Color color;
  final String priceChange24H;
  final String currentPrice;
  final CoinData coin;

  @override
  Widget build(BuildContext context) {
    return 
    GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => CoinDetailScreen(coin: coin)),
        );
      },
      child: 
      ListTile(
        contentPadding: const EdgeInsets.only(
          left: 16,
          right: 18,
          top: 16,
          bottom: 18,
        ),
        leading: CircleAvatar(
          radius: 22,
          backgroundColor: Colors.transparent,
          backgroundImage: NetworkImage(imagepath),
        ),
        title: Row(
          children: [
            Expanded(
              child: SizedBox(
                // width: 10,
                child: Text(
                  coinName,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w200,
                    fontSize: 16,
                  ),
                ),
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 30,
                  width: 30,
                  child: LineChart(
                    LineChartData(
                      gridData: const FlGridData(show: false),
                      titlesData: const FlTitlesData(show: false),
                      borderData: FlBorderData(show: false),
                      lineTouchData: LineTouchData(enabled: false),
                      minY: spots.isEmpty
                          ? 0
                          : spots
                                    .map((s) => s.y)
                                    .reduce((a, b) => a < b ? a : b) *
                                0.995,
                      maxY: spots.isEmpty
                          ? 0
                          : spots
                                    .map((s) => s.y)
                                    .reduce((a, b) => a > b ? a : b) *
                                1.005,
                      lineBarsData: [
                        LineChartBarData(
                          isCurved: true, // smooth line for weekly trend
                          color: color, // red for downtrend, green for uptrend
                          barWidth: 2,
                          spots: spots, // list of daily prices
                          dotData: const FlDotData(show: false),
                          belowBarData: BarAreaData(
                            show: true,
                            color: Colors.transparent, // subtle fill under line
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
        subtitle: Text(
          coinSymbol,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            fontSize: 12,
            color: Theme.of(context).colorScheme.secondary,
            fontWeight: FontWeight.w400,
          ),
        ),
        trailing: SizedBox(
          width: 110,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                currentPrice,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 16,
                ),
              ),
              Text(
                priceChange24H,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: color,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
