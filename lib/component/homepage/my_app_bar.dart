import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kingcrpt/provider/market_provider.dart';
import 'package:kingcrpt/util/custom_text_field.dart';
import 'package:provider/provider.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final marketProvider = Provider.of<MarketProvider>(context);
    return SingleChildScrollView(
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: marketProvider.isSearching
                      ? CustomTextField(
                          onChanged: (value) => marketProvider.setQuery(value),
                          text: 'Search Cryptocurrency...',
                        )
                      : Row(
                          children: [
                            SvgPicture.asset(
                              'assets/images/cryptologo.svg',
                              width: 20,
                              height: 20,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              'KingCrypt',
                              style: Theme.of(
                                context,
                              ).textTheme.headlineLarge!.copyWith(fontSize: 20),
                              maxLines: 2,
                            ),
                          ],
                        ),
                ),
                marketProvider.isSearching
                    ? TextButton(
                        onPressed: () => marketProvider.toggleSearch(),
                        child: Text('Cancel', style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.secondary
                        ),),
                      )
                    : IconButton(
                        onPressed: () => marketProvider.toggleSearch(),
                        icon: Icon(Icons.search, size: 30),
                      ),
              ],
            ),
            const SizedBox(height: 46),
            if (!marketProvider.isSearching)
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Coins',
                      style: Theme.of(
                        context,
                      ).textTheme.headlineLarge!.copyWith(fontSize: 20),
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
