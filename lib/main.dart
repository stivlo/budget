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
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (ctx) => CurrencyProvider()),
        ],
        child: Consumer<CurrencyProvider>(
          builder: (ctx, currencyProvider, _) => MaterialApp(
            title: 'Budget Fairy',
            theme: themeData(ctx),
            home: buildHomeScreen(currencyProvider),
            routes: const {},
          ),
        ),
      );

  FutureBuilder<bool> buildHomeScreen(CurrencyProvider currencyProvider) => FutureBuilder(
      future: currencyProvider.hasCurrency(),
      builder: (ctx, resultSnapshot) =>
          resultSnapshot.connectionState == ConnectionState.waiting
              ? const Center(child: CircularProgressIndicator())
              : resultSnapshot.data == true
                  ? HomeScreen(currencyProvider)
                  : CurrencyScreen(currencyProvider));

  ThemeData themeData(BuildContext context) => ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange.shade900),
        useMaterial3: true,
        elevatedButtonTheme: elevatedButtonThemeData(context),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.orange.shade800,
          titleTextStyle: const TextStyle(fontSize: 22),
        ),
      );

  ElevatedButtonThemeData elevatedButtonThemeData(BuildContext context) =>
      ElevatedButtonThemeData(
        style: ButtonStyle(
          side: MaterialStateProperty.resolveWith<BorderSide>(
              (states) => const BorderSide(color: Colors.black)),
          backgroundColor: background(context),
          shape: MaterialStateProperty.resolveWith<OutlinedBorder>((_) {
            return RoundedRectangleBorder(borderRadius: BorderRadius.circular(20));
          }),
          elevation: MaterialStateProperty.resolveWith<double>(
              (states) => states.contains(MaterialState.pressed) ? 0.0 : 5.0),
          textStyle: MaterialStateProperty.resolveWith<TextStyle>((states) {
            return const TextStyle(color: Colors.black);
          }),
        ),
      );

  MaterialStateProperty<Color> simpleBackground() =>
      MaterialStateProperty.resolveWith<Color>((states) => Colors.white);

  MaterialStateProperty<Color?>? background(BuildContext context) {
    return MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
      if (states.contains(MaterialState.pressed)) {
        return Theme.of(context).colorScheme.primary.withOpacity(0.5);
      }
      return null; // Use the component's default.
    });
  }
}
