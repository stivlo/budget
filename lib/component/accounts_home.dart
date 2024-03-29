import 'package:budget/provider/account_provider.dart';
import 'package:budget/screen/delete_account_screen.dart';
import 'package:budget/screen/rename_account_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../helper/themes.dart';
import '../model/account.dart';
import '../screen/create_account_screen.dart';
import '../shared/menu_action.dart';
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
      child: buildContentLoader(),
    );
  }

  Widget buildContentLoader() {
    final accountsLoader = ref.watch(accountListProvider);
    return accountsLoader.when(
      data: (accounts) => buildContent(),
      error: (err, _) => Padding(
        padding: const EdgeInsets.all(20),
        child: Text('Error Loading accounts: $err'),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }

  Widget buildContent() {
    final accounts = ref.watch(accountProvider);
    return Column(
      children: [
        Stack(
          children: [
            buildAccountHeading(),
            if (_createNewAccountButton) buildCreateNewAccountButton(),
          ],
        ),
        if (accounts.isNotEmpty) buildAccountTable(accounts),
        if (accounts.isEmpty) const SizedBox(height: 20),
      ],
    );
  }

  Widget buildAccountHeading() => ListTile(
        onTap: () => setState(() => _createNewAccountButton = !_createNewAccountButton),
        leading: const CircleIcon(Icons.account_balance, Colors.blue),
        title: const Text('Accounts', style: Themes.titleLarge),
      );

  Widget buildCreateNewAccountButton() => Positioned(
        top: 5,
        right: 10,
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

  Widget menuOptionTile(IconData iconData, String title, {bool enabled = true}) => Row(
        children: [
          Icon(iconData, size: 16),
          const SizedBox(width: 8),
          Text(
            title,
            style: enabled ? Themes.bodySmall : Themes.bodySmallDisabled,
          ),
        ],
      );

  Widget wrapWithPopupMenu(Widget child, Account account) => PopupMenuButton<MenuAction>(
        elevation: 5,
        itemBuilder: (BuildContext context) {
          return <PopupMenuEntry<MenuAction>>[
            PopupMenuItem<MenuAction>(
              value: MenuAction.transactionsForAccount,
              height: 35,
              child: menuOptionTile(Icons.swap_horiz, 'Transactions'),
            ),
            PopupMenuItem<MenuAction>(
              value: MenuAction.transferFrom,
              height: 35,
              child: menuOptionTile(Icons.compare_arrows, 'Transfer From'),
            ),
            PopupMenuItem<MenuAction>(
              value: MenuAction.renameAccount,
              height: 35,
              child: menuOptionTile(Icons.edit, 'Rename'),
            ),
            PopupMenuItem<MenuAction>(
              value: MenuAction.deleteAccount,
              height: 35,
              child: menuOptionTile(Icons.delete, 'Delete'),
            ),
            PopupMenuItem<MenuAction>(
              enabled: false,
              height: 35,
              child: Column(
                children: [
                  const Divider(),
                  menuOptionTile(Icons.account_balance, account.name, enabled: false),
                ],
              ),
            ),
          ];
        },
        onSelected: (MenuAction choice) {
          switch (choice) {
            case MenuAction.renameAccount:
              Navigator.of(context).pushNamed(
                RenameAccountScreen.routeName,
                arguments: account,
              );
              break;
            case MenuAction.deleteAccount:
              Navigator.of(context).pushNamed(
                DeleteAccountScreen.routeName,
                arguments: account,
              );
              break;
            default:
          }
        },
        child: child,
      );

  Widget buildAccountTable(List<Account> accounts) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: DataTable(
            // border: TableBorder.all(),
            horizontalMargin: 4,
            columnSpacing: 4,
            columns: const [
              DataColumn(label: Text('Name')),
              DataColumn(label: Text('Change'), numeric: true),
              DataColumn(label: Text('Balance'), numeric: true),
            ],
            rows: accounts
                .map((account) => DataRow(
                      cells: [
                        DataCell(
                          ConstrainedBox(
                            constraints:
                                const BoxConstraints(minWidth: 100, maxWidth: 200),
                            child: wrapWithPopupMenu(
                                Text('${account.currency.flag} ${account.name}'),
                                account),
                          ),
                        ),
                        DataCell(Text('${account.currency.symbol} +22.91')),
                        DataCell(Text('${account.currency.symbol} +45.12')),
                      ],
                    ))
                .toList()),
      );
}
