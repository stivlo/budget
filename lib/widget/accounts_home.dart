import 'package:flutter/material.dart';

import '../screen/create_account_screen.dart';
import 'circle_icon.dart';

class AccountsHome extends StatefulWidget {
  const AccountsHome({super.key});

  @override
  State<AccountsHome> createState() => _AccountsHomeState();
}

class _AccountsHomeState extends State<AccountsHome> {
  bool _createNewAccountButton = false;

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
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
            buildAccountTable(),
          ],
        ));
  }

  Widget buildAccountHeading() => ListTile(
        onTap: () {
          setState(() {
            _createNewAccountButton = !_createNewAccountButton;
          });
        },
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
          onPressed: () {
            Navigator.of(context).pushNamed(CreateAccountScreen.routeName);
          },
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

  Widget buildAccountTable() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: DataTable(
          // border: TableBorder.all(),
          columns: const [
            DataColumn(label: Text('Name')),
            DataColumn(label: Text('Change'), numeric: true),
            DataColumn(label: Text('Balance'), numeric: true),
          ],
          rows: const [
            DataRow(
              cells: [
                DataCell(Text('Cash (£)')),
                DataCell(Text('+22.91')),
                DataCell(Text('+45.12')),
              ],
            )
          ],
        ),
      );
}
