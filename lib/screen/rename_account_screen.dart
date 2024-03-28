import 'package:budget/component/cancel_action_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../helper/themes.dart';
import '../model/account.dart';
import '../provider/account_provider.dart';
import 'home_screen.dart';

class RenameAccountScreen extends ConsumerStatefulWidget {
  const RenameAccountScreen({super.key});

  static const routeName = '/rename-account';

  @override
  ConsumerState<RenameAccountScreen> createState() => _RenameAccountScreenState();
}

class _RenameAccountScreenState extends ConsumerState<RenameAccountScreen> {
  final _form = GlobalKey<FormState>();
  late Account _account;

  void _saveName(String? name) {
    if (name != null) {
      _account = _account.copyWith(name: name);
    }
  }

  void _submitForm() {
    if (_form.currentState != null && _form.currentState!.validate()) {
      _form.currentState!.save();
      ref.read(accountProvider.notifier).renameAccount(_account.id, _account.name);
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    _account = ModalRoute.of(context)!.settings.arguments as Account;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rename Account'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Account Name', style: Themes.titleMedium),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Account Name',
                  filled: true,
                ),
                initialValue: _account.name,
                textInputAction: TextInputAction.next,
                validator: Account.validateName,
                maxLength: Account.nameMaxLength,
                onSaved: _saveName,
              ),
              CancelActionButtons(
                actionLabel: 'Rename',
                action: _submitForm,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
