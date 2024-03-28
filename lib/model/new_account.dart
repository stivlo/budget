import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';

import 'currency.dart';

// Contains the information to create a new account
class NewAccount {
  NewAccount.empty()
      : name = '',
        currency = Currency.nul,
        initialBalance = Decimal.parse('0'),
        initialBalanceDate = DateTime.now();

  NewAccount({
    required this.name,
    required this.currency,
    required this.initialBalance,
    required initialBalanceDate,
  }) : initialBalanceDate = DateUtils.dateOnly(initialBalanceDate);

  final String name;
  final Currency currency;
  final Decimal initialBalance;
  final DateTime initialBalanceDate;

  NewAccount copyWith({
    String? name,
    Currency? currency,
    Decimal? initialBalance,
    DateTime? initialBalanceDate,
  }) {
    return NewAccount(
      name: name ?? this.name,
      currency: currency ?? this.currency,
      initialBalance: initialBalance ?? this.initialBalance,
      initialBalanceDate: initialBalanceDate ?? this.initialBalanceDate,
    );
  }

  Map<String, dynamic> toMap() => {
        'name': name,
        'currency': currency.abbreviation,
      };

  @override
  String toString() {
    return 'NewAccount{name: $name, '
        'currency: $currency, '
        'initialBalance: $initialBalance, '
        'initialBalanceDate: $initialBalanceDate}';
  }
}
