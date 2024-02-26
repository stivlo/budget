import 'package:flutter/foundation.dart';

import '../model/currency.dart';

class CurrencyProvider with ChangeNotifier {
  Currency? selectedCurrency;

  Future<Currency?> fetchCurrency() async {
    if (selectedCurrency != null) return selectedCurrency;
    return null;
  }

  Future<bool> hasCurrency() async => await fetchCurrency() != null;

  Future<void> saveCurrency(Currency currency) async {
    selectedCurrency = currency;
    notifyListeners();
  }
}
