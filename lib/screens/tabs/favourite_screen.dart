import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kingcrpt/model/coingeckomodel.dart';
import 'package:kingcrpt/provider/market_provider.dart';
import 'package:kingcrpt/util/custom_List_Tile.dart';
import 'package:provider/provider.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  List<FlSpot> _getSparklineSpots(CoinData coin) {
    return coin.sparkline.asMap().entries.map((entry) {
      return FlSpot(entry.key.toDouble(), entry.value);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final market = Provider.of<MarketProvider>(context);
    final favourites = market.filteredFavourites;

    if (favourites.isEmpty) {
      return Center(
        
        child: Column(
          
          children: [
            SizedBox(height: 89,),
            SvgPicture.asset('assets/images/emptyfavoriteimage.svg'),
            SizedBox(height: 8,),
            Text(
              "Special Place for avourite coins yet ",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w400
              ),
            ),
            SizedBox(height: 8,),
            Text(
              "Add your Favourite coins and check here easily",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Theme.of(context).colorScheme.secondary
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      color: Theme.of(context).colorScheme.primary,
      backgroundColor: Theme.of(context).colorScheme.surface,
      onRefresh: () => market.fetchData(useCache: false),
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: favourites.length,
        itemBuilder: (context, index) {
          final coin = favourites[index];
          final isUp = (coin.priceChangePercentage24H ?? 0) >= 0;

          return Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context)
                      .colorScheme
                      .onSecondary
                      .withOpacity(0.1),
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
              color: isUp ? const Color(0xFF21BF73) : const Color(0xFFD90429),
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