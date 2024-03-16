import 'dart:convert';

import 'package:budget/provider/currency_provider.dart';
import 'package:budget/provider/date_range_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

import 'helper/date_time_helper.dart';
import 'model/currency.dart';
import 'screen/currency_screen.dart';
import 'screen/home_screen.dart';

const allocateBudgetTaskName = 'allocate-budget';

void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    switch (taskName) {
      case allocateBudgetTaskName:
        print('background task start v1: ${DateTime.now().toIso8601String()} ');
        var prefs = await SharedPreferences.getInstance();
        String cronJson = prefs.getString('cron') ?? '[]';
        cronJson = '[]';
        List executions = json.decode(cronJson);
        executions.add(DateTimeHelper.formattedTime());
        cronJson = json.encode(executions);
        prefs.setString('cron', cronJson);
        print('background task end v1: $cronJson');
        break;
    }
    return true;
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // var uniqueId = DateTime.now().toIso8601String();
  final workmanager = Workmanager();
  workmanager.cancelAll();
  await workmanager.initialize(callbackDispatcher);
  await workmanager.registerPeriodicTask(
    allocateBudgetTaskName,
    allocateBudgetTaskName,
    frequency: const Duration(minutes: 15),
    initialDelay: const Duration(minutes: 1),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (ctx) => CurrencyProvider()),
          ChangeNotifierProvider(create: (ctx) => DateRangeProvider()),
        ],
        child: Consumer<CurrencyProvider>(
          builder: (ctx, currencyProvider, _) => MaterialApp(
            title: 'Budget Pilot',
            theme: themeData(ctx),
            home: buildHomeScreen(currencyProvider),
            routes: {
              CurrencyScreen.routeName: (_) => FutureBuilder(
                    future: currencyProvider.fetchCurrency(),
                    builder: (_, currencySnapshot) =>
                        currencySnapshot.connectionState == ConnectionState.waiting
                            ? const Center(child: CircularProgressIndicator())
                            : CurrencyScreen(
                                currencyProvider,
                                currencySnapshot.data,
                              ),
                  )
            },
          ),
        ),
      );

  FutureBuilder<Currency?> buildHomeScreen(CurrencyProvider currencyProvider) =>
      FutureBuilder(
        future: currencyProvider.fetchCurrency(),
        builder: (ctx, currencySnapshot) =>
            currencySnapshot.connectionState == ConnectionState.waiting
                ? const Center(child: CircularProgressIndicator())
                : currencySnapshot.data != null
                    ? HomeScreen(currencyProvider)
                    : CurrencyScreen(
                        currencyProvider,
                        currencySnapshot.data,
                      ),
      );

  ThemeData themeData(BuildContext context) => ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange.shade900),
        useMaterial3: true,
        elevatedButtonTheme: elevatedButtonThemeData(context),
        textButtonTheme: textButtonThemeData(context),
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyMedium: const TextStyle(fontSize: 13),
            ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.orange.shade800,
          titleTextStyle: const TextStyle(fontSize: 22),
        ),
      );

  TextButtonThemeData textButtonThemeData(BuildContext context) =>
      const TextButtonThemeData(
        style: ButtonStyle(
          padding: MaterialStatePropertyAll(EdgeInsets.zero),
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
