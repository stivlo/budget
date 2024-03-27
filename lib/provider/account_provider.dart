import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/account.dart';
import '../model/currency.dart';
import '../model/new_account.dart';
import '../shared/db_handler.dart';

class AccountNotifier extends StateNotifier<List<Account>> {
  AccountNotifier() : super([]);

  final db = DbHandler();

  Future<void> addAccount(NewAccount account) async {
    await db.insert('account', {
      'name': account.name,
      'currency': account.currency.abbreviation,
    });
  }

  Future<List<Account>> fetchAccounts() async {
    var result = await db.query('account');
    state = result
        .map(
          (e) => Account(
            id: e['id'] as int,
            name: e['name'] as String,
            currency: Currency.findByAbbreviation(e['currency'] as String),
          ),
        )
        .toList();
    return state;
  }
}

final accountProvider =
    StateNotifierProvider<AccountNotifier, List<Account>>((ref) => AccountNotifier());

final accountListProvider = FutureProvider<List<Account>>((ref) async {
  final accountNotifier = ref.read(accountProvider.notifier);
  return accountNotifier.fetchAccounts();
});
