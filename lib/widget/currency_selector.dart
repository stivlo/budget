import 'package:flutter/material.dart';

import '../model/currency.dart';

class CurrencySelector extends StatelessWidget {
  const CurrencySelector(this.selectedCurrency, this._onSelectedCurrency, {super.key});

  final Currency? selectedCurrency;
  final Function _onSelectedCurrency;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<Currency>(
      initialSelection: selectedCurrency,
      enableFilter: true,
      requestFocusOnTap: true,
      leadingIcon: const Icon(Icons.search),
      label: const Text('Currency'),
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        contentPadding: EdgeInsets.symmetric(vertical: 5.0),
      ),
      onSelected: (Currency? currency) => _onSelectedCurrency(currency),
      dropdownMenuEntries: buildDropDownMenuEntries(),
    );
  }

  List<DropdownMenuEntry<Currency>> buildDropDownMenuEntries() => Currency.values
      .where((currency) => currency != Currency.nul)
      .map<DropdownMenuEntry<Currency>>(
        (Currency currency) => DropdownMenuEntry<Currency>(
            value: currency,
            leadingIcon: Text('${currency.flag} ${currency.abbreviation}'),
            label: currency.name,
            trailingIcon: Text(currency.symbol)),
      )
      .toList();
}
