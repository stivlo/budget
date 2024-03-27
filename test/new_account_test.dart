import 'package:budget/model/currency.dart';
import 'package:budget/model/new_account.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final NewAccount account = NewAccount.empty();

  test('can set account name', () {
    var name = 'Account Name';
    var modifiedAccount = account.copyWith(name: name);
    expect(modifiedAccount.name, name);
  });

  test('can set account currency', () {
    var modifiedAccount = account.copyWith(currency: Currency.usd);
    expect(modifiedAccount.currency, Currency.usd);
  });

  test('can set initial balance', () {
    var newInitialBalance = Decimal.parse('12.23');
    var modifiedAccount = account.copyWith(initialBalance: newInitialBalance);
    expect(modifiedAccount.initialBalance, newInitialBalance);
  });

  test('can set initial balance date', () {
    var newDate = DateTime.parse('2024-01-01');
    var modifiedAccount = account.copyWith(initialBalanceDate: newDate);
    expect(modifiedAccount.initialBalanceDate, newDate);
  });
}
