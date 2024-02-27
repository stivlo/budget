import 'package:flutter/material.dart';

import '../model/currency.dart';
import '../provider/currency_provider.dart';
import '../widget/currency_selector.dart';

class CurrencyScreen extends StatefulWidget {
  const CurrencyScreen(this.currencyProvider, {super.key});

  final CurrencyProvider currencyProvider;

  @override
  State<CurrencyScreen> createState() => _CurrencyScreenState();
}

class _CurrencyScreenState extends State<CurrencyScreen> {
  Currency? selectedCurrency;

  void _onSelectedCurrency(Currency currency) =>
      setState(() => selectedCurrency = currency);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Row(
            children: [Text('Budget Fairy')],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: content(),
        ),
      );

  Widget content() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Text('Principles', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 10),
          const Text('- Allocate all of your income'),
          const SizedBox(height: 10),
          const Text('- Allocate budgets per category'),
          const SizedBox(height: 10),
          const Text('- Track your expenses daily'),
          const SizedBox(height: 10),
          const Text('- Make adjustments as needed'),
          const SizedBox(height: 30),
          Text('Choose Currency', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 20),
          CurrencySelector(selectedCurrency, _onSelectedCurrency),
          const SizedBox(height: 20),
          if (selectedCurrency != null)
            ElevatedButton(onPressed: onPressed(), child: const Text('Next >'))
        ],
      );

  VoidCallback? onPressed() {
    VoidCallback? callback = selectedCurrency == null ? null : saveCurrency;
    print('onPressed $selectedCurrency $callback');
    return callback;
  }

  void saveCurrency() => widget.currencyProvider.saveCurrency(selectedCurrency!);
}
