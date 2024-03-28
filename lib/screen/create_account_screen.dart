import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components/cancel_action_buttons.dart';
import '../helper/date_time_helper.dart';
import '../model/account.dart';
import '../model/currency.dart';
import '../model/new_account.dart';
import '../provider/account_provider.dart';
import '../provider/default_currency_provider.dart';
import '../widget/currency_selector.dart';

class CreateAccountScreen extends ConsumerStatefulWidget {
  const CreateAccountScreen({super.key});

  static const routeName = '/create-account-screen';

  @override
  ConsumerState<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends ConsumerState<CreateAccountScreen> {
  _CreateAccountScreenState() : _account = NewAccount.empty() {
    _initialBalanceDateController = TextEditingController(
        text: DateTimeHelper.formattedShortDate(_account.initialBalanceDate));
  }

  NewAccount _account;
  final _form = GlobalKey<FormState>();
  late TextEditingController _initialBalanceDateController;

  void _submitForm() {
    if (_form.currentState != null && _form.currentState!.validate()) {
      _form.currentState!.save();
    }
    ref.read(accountProvider.notifier).createAccount(_account);
    Navigator.of(context).pushReplacementNamed('/');
  }

  String? _validateName(String? name) {
    if (name == null || name.isEmpty) {
      return 'Provide an account name';
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

  Future<void> _showDatePicker() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _account.initialBalanceDate,
      firstDate: DateTime(2023),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (pickedDate != null) {
      _initialBalanceDateController.text = DateTimeHelper.formattedShortDate(pickedDate);
      _account = _account.copyWith(initialBalanceDate: pickedDate);
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
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Account Name',
                    filled: true,
                  ),
                  textInputAction: TextInputAction.next,
                  validator: _validateName,
                  maxLength: Account.nameMaxLength,
                  onSaved: _saveName,
                ),
                const SizedBox(height: 20),
                CurrencySelector(
                  context: context,
                  selectedCurrency: ref.read(defaultCurrencyProvider),
                  saveCurrency: _saveCurrency,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Initial Balance',
                    filled: true,
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  validator: _validateInitialBalance,
                  onSaved: _saveInitialBalance,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Initial Balance Date',
                    filled: true,
                    suffixIcon: Icon(Icons.today),
                  ),
                  textInputAction: TextInputAction.next,
                  readOnly: true,
                  onTap: _showDatePicker,
                  controller: _initialBalanceDateController,
                ),
                const SizedBox(height: 20),
                CancelActionButtons(action: _submitForm, actionLabel: 'Create'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
