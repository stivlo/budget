import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/account.dart';
import '../model/new_account.dart';
import '../shared/db_handler.dart';

class AccountNotifier extends StateNotifier<List<Account>> {
  AccountNotifier() : super([]);

  final db = DbHandler();
  static const accountTable = 'account';

  Future<List<Account>> fetchAccounts() async {
    var result = await db.query('account');
    state = result.map((e) => Account.fromMap(e)).toList();
    return state;
  }

  Future<void> createAccount(NewAccount account) async {
    await db.insert(accountTable, account.toMap());
    await fetchAccounts();
  }

  Future<void> deleteAccount(int id) async {
    await db.delete(accountTable, where: 'id=?', whereArgs: [id]);
    await fetchAccounts();
  }

  Future<void> renameAccount(int id, String name) async {
    await db.update(accountTable, {'name': name}, where: 'id=?', whereArgs: [id]);
    await fetchAccounts();
  }
}

final accountProvider =
    StateNotifierProvider<AccountNotifier, List<Account>>((ref) => AccountNotifier());

final accountListProvider = FutureProvider<List<Account>>((ref) async {
  final accountNotifier = ref.watch(accountProvider.notifier);
  return accountNotifier.fetchAccounts();
});
