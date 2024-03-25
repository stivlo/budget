import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/currency.dart';
import '../provider/default_currency_provider.dart';
import '../widget/currency_selector.dart';
import 'home_screen.dart';

class CurrencyScreen extends ConsumerStatefulWidget {
  const CurrencyScreen({super.key});

  static const routeName = '/currency';

  @override
  ConsumerState<CurrencyScreen> createState() => _CurrencyScreenState();
}

class _CurrencyScreenState extends ConsumerState<CurrencyScreen> {
  final _form = GlobalKey<FormState>();
  late Currency currency;
  late NavigatorState navigatorState;

  @override
  Widget build(BuildContext context) {
    currency = ref.watch(defaultCurrencyProvider);
    navigatorState = Navigator.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [Text('Budget Pilot')],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: content(context, currency),
      ),
    );
  }

  Widget content(BuildContext context, Currency currency) => SingleChildScrollView(
        child: Column(
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
            Text('Choose Default Currency',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 20),
            Form(
              key: _form,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CurrencySelector(
                    context: context,
                    selectedCurrency: currency,
                    saveCurrency: _saveCurrencyToLocalState,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: submitForm,
                    child: const Text('Save'),
                  )
                ],
              ),
            ),
          ],
        ),
      );

  void submitForm() async {
    if (_form.currentState != null && _form.currentState!.validate()) {
      _form.currentState!.save();
    }
    await ref.read(defaultCurrencyProvider.notifier).saveCurrency(currency);
    await navigatorState.pushReplacementNamed(HomeScreen.routeName);
  }

  void _saveCurrencyToLocalState(Currency? currency) {
    if (currency != null) {
      setState(() {
        this.currency = currency;
      });
    }
  }
}
