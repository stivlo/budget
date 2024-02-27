import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/currency.dart';

class CurrencyProvider with ChangeNotifier {
  static const currencyKey = 'currency';
  Currency? selectedCurrency;

  Future<Currency?> fetchCurrency() async {
    if (selectedCurrency != null) return selectedCurrency;
    final prefs = await SharedPreferences.getInstance();
    String? currencyAbbreviation = prefs.getString(currencyKey);
    if (currencyAbbreviation != null) {
      try {
        Currency savedCurrency = Currency.values
            .firstWhere((element) => element.abbreviation == currencyAbbreviation);
        if (selectedCurrency != savedCurrency) {
          selectedCurrency = savedCurrency;
          notifyListeners();
        }
      } catch (_) {
        return null;
      }
    }
    return null;
  }

  Future<bool> hasCurrency() async => await fetchCurrency() != null;

  Future<void> saveCurrency(Currency currency) async {
    print('saveCurrency $currency');
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(currencyKey, currency.abbreviation);
    if (selectedCurrency != currency) {
      selectedCurrency = currency;
      notifyListeners();
    }
  }
}
