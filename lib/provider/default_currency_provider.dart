import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/currency.dart';

class DefaultCurrencyNotifier extends StateNotifier<Currency> {
  DefaultCurrencyNotifier() : super(Currency.nul);

  static const currencyKey = 'currency';

  Future<Currency> fetchCurrency() async {
    if (state != Currency.nul) {
      return state;
    }
    final prefs = await SharedPreferences.getInstance();
    // await prefs.remove(currencyKey);
    String? currencyAbbreviation = prefs.getString(currencyKey);
    if (currencyAbbreviation != null) {
      Currency savedCurrency = Currency.values
          .firstWhere((currency) => currency.abbreviation == currencyAbbreviation);
      if (state != savedCurrency) {
        state = savedCurrency;
      }
    }
    return state;
  }

  Future<void> saveCurrency(Currency currency) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(currencyKey, currency.abbreviation);
    if (state != currency) {
      state = currency;
    }
  }
}

final defaultCurrencyProvider = StateNotifierProvider<DefaultCurrencyNotifier, Currency>(
  (ref) => DefaultCurrencyNotifier(),
);
