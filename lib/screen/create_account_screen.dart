import 'package:budget/widget/cancel_button.dart';
import 'package:flutter/material.dart';

import '../model/currency.dart';
import '../widget/action_button.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  static const routeName = '/create-account-screen';

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New Account'),
      ),
      // Account Name, Currency, Initial Balance, Create Button
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          // consider SingleChildScrollView + Column instead of ListView
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Account Name'),
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 30),
              DropdownButtonFormField(
                  decoration: const InputDecoration.collapsed(hintText: 'Currency'),
                  icon: const Icon(Icons.arrow_downward),
                  items: buildMenuItems(),
                  onChanged: (_) {}),
              const SizedBox(height: 30),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Initial Balance'),
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 50),
              const Row(
                children: [
                  CancelButton(),
                  SizedBox(width: 40),
                  ActionButton(label: 'Create'),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem<Currency>> buildMenuItems() {
    return Currency.values
        .map(
          (e) => DropdownMenuItem<Currency>(
            value: e,
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 120,
              height: 28,
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
