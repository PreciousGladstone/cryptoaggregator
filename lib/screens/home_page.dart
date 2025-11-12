import 'package:flutter/material.dart';
import 'package:kingcrpt/component/homepage/my_app_bar.dart';
import 'package:kingcrpt/component/homepage/my_tab.dart';
import 'package:kingcrpt/screens/tabs/all_coins_screen.dart';
import 'package:kingcrpt/screens/tabs/favourite_screen.dart';
import 'package:kingcrpt/screens/tabs/gainers_screen.dart';
import 'package:kingcrpt/screens/tabs/losers_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  List tabOptions = [
    ['All', AllCoinsScreen()],
    ['Gainer', GainersScreen()],
    ['Loser', LosersScreen()],
    ['Favourite', FavouriteScreen()],
  ];

  @override
  void initState() {
    _tabController = TabController(length: tabOptions.length, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) return;
      final tabName = tabOptions[_tabController.index][0];
      debugPrint("Switched to tab: $tabName");
    });
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            children: [
              MyAppBar(),
              SizedBox(height: 24),
                Expanded(
                  child: MyTabBar(
                    tabOptions: tabOptions,
                    tabController: _tabController,
                  ),
                ),
              
            ],
          ),
        ),
      );
  }
}
