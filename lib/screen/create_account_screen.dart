import 'package:budget/widget/cancel_button.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';

import '../model/currency.dart';
import '../model/new_account.dart';
import '../widget/action_button.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  static const routeName = '/create-account-screen';

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final _form = GlobalKey<FormState>();
  var _account = NewAccount(
    name: '',
    currency: Currency.nul,
    initialBalance: Decimal.parse('0'),
    initialBalanceDate: DateTime.now(),
  );

  void _createAccount() {
    print('saving form... ${_form.currentState}');
    _form.currentState?.save();
    print('account: $_account');
  }

  void _saveName(String? name) {
    print('saving name: $name');
    if (name != null) {
      _account = _account.copyWith(name: name);
    }
  }

  void _saveCurrency(Currency? currency) {
    print('saving currency: $currency');
    if (currency != null) {
      _account = _account.copyWith(currency: currency);
    }
  }

  void _saveInitialBalance(String? initialBalance) {
    print('saving initialBalance: $initialBalance');
    if (initialBalance != null) {
      try {
        _account = _account.copyWith(initialBalance: Decimal.parse(initialBalance));
      } catch (error) {
        // do nothing in case of errors for now
        print(error);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New Account'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Create accounts for any saving or current account, '
                  'credit card, cash, and mortgage accounts.',
                  textAlign: TextAlign.justify,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Account Name'),
                  textInputAction: TextInputAction.next,
                  onSaved: _saveName,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField(
                  decoration: const InputDecoration(
                    labelText: 'Currency',
                    contentPadding: EdgeInsets.symmetric(vertical: 18),
                  ),
                  icon: const Icon(Icons.arrow_downward),
                  items: buildMenuItems(),
                  onChanged: (_) {},
                  onSaved: _saveCurrency,
                ),
                const SizedBox(height: 30),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Initial Balance'),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  onSaved: _saveInitialBalance,
                ),
                const SizedBox(height: 50),
                Row(
                  children: [
                    CancelButton(Navigator.of(context)),
                    const SizedBox(width: 40),
                    ActionButton(
                      label: 'Create',
                      onPressed: _createAccount,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem<Currency>> buildMenuItems() {
    return Currency.values
        .where((currency) => currency != Currency.nul)
        .map(
          (e) => DropdownMenuItem<Currency>(
            value: e,
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 120,
              height: 32,
              child: ListTile(
                leading: Text('${e.flag} ${e.abbreviation}'),
                title: Text('${e.name} (${e.symbol})'),
              ),
            ),
          ),
        )
        .toList();
  }
}
