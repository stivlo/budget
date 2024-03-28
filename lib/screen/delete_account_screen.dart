import 'package:budget/component/cancel_action_buttons.dart';
import 'package:budget/provider/account_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../helper/themes.dart';
import '../model/account.dart';

class DeleteAccountScreen extends ConsumerWidget {
  const DeleteAccountScreen({super.key});

  static const routeName = '/delete-account';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final account = ModalRoute.of(context)!.settings.arguments as Account;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delete Account'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Account Name', style: Themes.titleMedium),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(10.0),
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1.0),
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Text(account.name, style: Themes.titleMedium),
            ),
            const SizedBox(height: 20),
            CancelActionButtons(
              actionLabel: 'Delete',
              action: () => _delete(context, ref, account.id),
            ),
          ],
        ),
      ),
    );
  }

  void _delete(BuildContext context, WidgetRef ref, int id) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: const Text('Deleting Account'),
          content: const Text('Are you sure to delete the account?'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('No'),
            ),
            const SizedBox(width: 15),
            ElevatedButton(
              onPressed: () {
                ref.read(accountProvider.notifier).deleteAccount(id);
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }
}
