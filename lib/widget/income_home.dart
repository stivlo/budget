import 'package:flutter/material.dart';

import 'circle_icon.dart';

class IncomeHome extends StatelessWidget {
  const IncomeHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        color: Colors.green[50],
        child: Column(
          children: [
            ListTile(
              leading: const CircleIcon(Icons.input_rounded, Colors.green),
              title: Text('Income', style: Theme.of(context).textTheme.titleLarge),
              subtitle: Text('Tap to set', style: Theme.of(context).textTheme.bodyMedium),
              trailing: Text('£ 0', style: Theme.of(context).textTheme.titleMedium),
            ),
          ],
        ));
  }
}
