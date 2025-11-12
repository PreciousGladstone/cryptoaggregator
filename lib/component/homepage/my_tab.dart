import 'package:flutter/material.dart';

class MyTabBar extends StatelessWidget {
  const MyTabBar({
    super.key,
    required this.tabOptions,
    required this.tabController,
  });

  final List tabOptions;
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return Column(
      //my tabbar using controller 
        
        children: [
          TabBar(
            controller: tabController,
            dividerColor: Color(0xFFDFE2E4),
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            unselectedLabelStyle: Theme.of(context).textTheme.headlineLarge!
                .copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.secondary,
                ),
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: Theme.of(context).colorScheme.primary,
            labelStyle: Theme.of(context).textTheme.headlineLarge!.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
      
            tabs: tabOptions
                .map<Widget>((tab) => Tab(text: tab[0].toString()))
                .toList(),
          ),
      
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: tabOptions
                  .map<Widget>((tab) => tab[1] as Widget)
                  .toList(),
            ),
          ),
        ],
      
    );
  }
}
