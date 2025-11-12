import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kingcrpt/provider/chart_type_provider.dart';
import 'package:kingcrpt/provider/market_provider.dart';
import 'package:kingcrpt/screens/home_page.dart';
import 'package:kingcrpt/theme/custom_dark_mode.dart';
import 'package:kingcrpt/theme/custom_light_mode.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  //initialize hive
  await Hive.initFlutter();
  //opening my box
  await Hive.openBox('Market Cache');
  //opening box for favourite 
  await Hive.openBox('Favourite');
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => MarketProvider()..loadFavorites()..fetchData()),
        ChangeNotifierProvider(create: (ctx) => ChartProvider())
        ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'King Crpt',
      theme: lightMode,         // light theme
      darkTheme: darkMode,      // dark theme
      themeMode: ThemeMode.system, // follows device/system theme
      home: HomePage(),
    );
  }
}
