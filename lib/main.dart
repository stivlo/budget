import 'package:budget/provider/default_currency_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'helper/theme_builder.dart';
import 'model/currency.dart';
import 'screen/create_account_screen.dart';
import 'screen/currency_screen.dart';
import 'screen/home_screen.dart';

void main() async {
  runApp(const ProviderScope(child: BudgetApp()));
}

class BudgetApp extends ConsumerWidget {
  const BudgetApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Budget Pilot',
        theme: ThemeBuilder.themeData(context),
        home: buildHomeScreen(ref),
        routes: {
          CurrencyScreen.routeName: (_) => FutureBuilder(
                future: ref.read(defaultCurrencyProvider.notifier).fetchCurrency(),
                builder: (_, currencySnapshot) =>
                    currencySnapshot.connectionState == ConnectionState.waiting
                        ? const Center(child: CircularProgressIndicator())
                        : const CurrencyScreen(),
              ),
          CreateAccountScreen.routeName: (_) => const CreateAccountScreen(),
        },
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
