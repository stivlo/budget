import 'package:budget/provider/default_currency_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'helper/themes.dart';
import 'model/currency.dart';
import 'screen/create_account_screen.dart';
import 'screen/currency_screen.dart';
import 'screen/home_screen.dart';

void main() async {
  runApp(const ProviderScope(child: BudgetApp()));
}

class BudgetApp extends ConsumerWidget {
  const BudgetApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Budget Pilot',
        theme: Themes.themeData(context),
        home: buildHomeScreen(ref),
        routes: {
          CurrencyScreen.routeName: (_) => buildCurrencyScreen(ref),
          CreateAccountScreen.routeName: (_) => const CreateAccountScreen(),
        },
      );

  Widget buildCurrencyScreen(WidgetRef ref) => FutureBuilder(
        future: ref.read(defaultCurrencyProvider.notifier).fetchCurrency(),
        builder: (_, currencySnapshot) =>
            currencySnapshot.connectionState == ConnectionState.waiting
                ? const Center(child: CircularProgressIndicator())
                : const CurrencyScreen(),
      );

  Widget buildHomeScreen(WidgetRef ref) => FutureBuilder(
      future: ref.watch(defaultCurrencyProvider.notifier).fetchCurrency(),
      builder: (_, currencySnapshot) {
        if (currencySnapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        return currencySnapshot.data == Currency.nul
            ? const CurrencyScreen()
            : const HomeScreen();
      });
}
