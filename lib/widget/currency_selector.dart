import 'package:flutter/material.dart';

import '../model/currency.dart';

class CurrencySelector extends StatelessWidget {
  const CurrencySelector({
    required this.context,
    required this.selectedCurrency,
    required this.saveCurrency,
    super.key,
  });

  final BuildContext context;
  final Currency? selectedCurrency;
  final void Function(Currency?)? saveCurrency;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      decoration: const InputDecoration(
        labelText: 'Currency',
        contentPadding: EdgeInsets.symmetric(vertical: 18),
      ),
      icon: const Icon(Icons.arrow_downward),
      value: selectedCurrency,
      items: buildMenuItems(),
      onChanged: (_) {},
      validator: _validateCurrency,
      onSaved: saveCurrency,
    );
  }

  String? _validateCurrency(Currency? currency) {
    if (currency == null || currency == Currency.nul) {
      return 'Select a currency';
    }
    return null;
  }

  List<DropdownMenuItem<Currency>> buildMenuItems() => Currency.values
      .where((currency) => currency != Currency.nul)
      .map(
        (e) => DropdownMenuItem<Currency>(
          value: e,
          child: SizedBox(
            width: MediaQuery.of(context).size.width - 60,
            height: 32,
            child: ListTile(
              leading: Text('${e.flag} ${e.abbreviation}'),
              title: Text('${e.name} (${e.symbol})'),
            ),
          ),
        ),
      )
      .toList();
}
