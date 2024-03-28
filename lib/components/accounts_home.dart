import 'package:budget/provider/account_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/account.dart';
import '../screen/create_account_screen.dart';
import '../widget/circle_icon.dart';

class AccountsHome extends ConsumerStatefulWidget {
  const AccountsHome({super.key});

  @override
  ConsumerState<AccountsHome> createState() => _AccountsHomeState();
}

class _AccountsHomeState extends ConsumerState<AccountsHome> {
  bool _createNewAccountButton = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: Colors.blue[50],
      margin: const EdgeInsets.all(3),
      child: Column(
        children: [
          Stack(
            children: [
              buildAccountHeading(),
              if (_createNewAccountButton) buildCreateNewAccountButton(),
            ],
          ),
          buildInitialAccountTable(),
        ],
      ),
    );
  }

  Widget buildAccountHeading() => ListTile(
        onTap: () => setState(() => _createNewAccountButton = !_createNewAccountButton),
        leading: const CircleIcon(Icons.account_balance, Colors.blue),
        title: Text(
          'Accounts',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      );

  Widget buildCreateNewAccountButton() => Positioned(
        top: 5,
        left: 180,
        child: TextButton(
          onPressed: () => Navigator.of(context).pushNamed(CreateAccountScreen.routeName),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.blue),
            fixedSize: MaterialStateProperty.all(
              const Size.fromWidth(160),
            ),
          ),
          child: const Text(
            'Create New Account',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );

  Widget buildInitialAccountTable() {
    final accountsLoader = ref.watch(accountListProvider);
    return accountsLoader.when(
      data: (accounts) => buildAccountTableWatcher(),
      error: (err, _) => Padding(
        padding: const EdgeInsets.all(20),
        child: Text('Error Loading accounts: $err'),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }

  Widget buildAccountTableWatcher() {
    final accounts = ref.watch(accountProvider);
    return buildAccountTable(accounts);
  }

  Widget buildAccountTable(List<Account> accounts) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: DataTable(
            // border: TableBorder.all(),
            columns: const [
              DataColumn(label: Text('Name')),
              DataColumn(label: Text('Change'), numeric: true),
              DataColumn(label: Text('Balance'), numeric: true),
            ],
            rows: accounts
                .map((e) => DataRow(
                      cells: [
                        DataCell(Text(
                          '${e.currency.flag} ${e.name} ${e.currency.symbol}',
                        )),
                        const DataCell(Text('+22.91')),
                        const DataCell(Text('+45.12')),
                      ],
                    ))
                .toList()),
      );
}
