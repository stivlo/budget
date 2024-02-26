import 'package:budget/provider/currency_provider.dart';
import 'package:budget/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screen/currency_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => CurrencyProvider()),
      ],
      child: Consumer<CurrencyProvider>(
        builder: (ctx, currencyProvider, _) => Consumer<CurrencyProvider>(
            builder: (ctx, currencyProvider, _) => MaterialApp(
                  title: 'Budget Fairy',
                  theme: ThemeData(
                    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                    useMaterial3: true,
                    appBarTheme: const AppBarTheme(
                      backgroundColor: Colors.purple,
                      titleTextStyle: TextStyle(
                        fontSize: 22,
                      ),
                    ),
                  ),
                  home: FutureBuilder(
                      future: currencyProvider.hasCurrency(),
                      builder: (ctx, resultSnapshot) =>
                          resultSnapshot.connectionState == ConnectionState.waiting
                              ? const Center(child: CircularProgressIndicator())
                              : resultSnapshot.data == true
                                  ? const HomeScreen()
                                  : CurrencyScreen(currencyProvider)),
                  routes: const {},
                )),
      ),
    );
  }
}
