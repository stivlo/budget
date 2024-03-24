import 'package:budget/components/cancel_action_buttons.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';

import '../model/currency.dart';
import '../model/new_account.dart';

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
    if (_form.currentState != null && _form.currentState!.validate()) {
      _form.currentState!.save();
      print('account: $_account');
    }
  }

  String? _validateName(String? name) {
    if (name == null || name.isEmpty) {
      return 'Provide an account name';
    }
    return null;
  }

  String? _validateCurrency(Currency? currency) {
    if (currency == null || currency == Currency.nul) {
      return 'Select a currency for the account';
    }
    return null;
  }

  String? _validateInitialBalance(String? balance) {
    if (balance == null || balance.isEmpty) {
      return 'Provide an initial balance for the account';
    }
    try {
      Decimal.parse(balance);
    } catch (err) {
      return 'Invalid balance, provide a positive or negative number';
    }
    return null;
  }

  void _saveName(String? name) {
    if (name != null) {
      _account = _account.copyWith(name: name);
    }
  }

  void _saveCurrency(Currency? currency) {
    if (currency != null) {
      _account = _account.copyWith(currency: currency);
    }
  }

  void _saveInitialBalance(String? initialBalance) {
    if (initialBalance != null) {
      // errors already checked in validate phase
      _account = _account.copyWith(initialBalance: Decimal.parse(initialBalance));
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
                const Text('Create accounts for any saving or current account, '
                    'credit card, cash, and mortgage accounts (negative balance).'),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Account Name'),
                  textInputAction: TextInputAction.next,
                  validator: _validateName,
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
                  validator: _validateCurrency,
                  onSaved: _saveCurrency,
                ),
                const SizedBox(height: 30),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Initial Balance'),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  validator: _validateInitialBalance,
                  onSaved: _saveInitialBalance,
                ),
                const SizedBox(height: 30),
                CancelActionButtons(action: _createAccount, actionLabel: 'Create'),
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
