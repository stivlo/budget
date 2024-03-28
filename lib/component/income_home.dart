import 'package:flutter/material.dart';

import '../helper/themes.dart';
import '../widget/circle_icon.dart';

class IncomeHome extends StatelessWidget {
  const IncomeHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 2,
        color: Colors.green[50],
        margin: const EdgeInsets.all(3),
        child: const Column(
          children: [
            ListTile(
              leading: CircleIcon(Icons.input_rounded, Colors.green),
              title: Text('Income', style: Themes.titleLarge),
              subtitle: Text('Tap to set', style: Themes.bodyMedium),
              trailing: Text('£ 0', style: Themes.titleMedium),
            ),
          ],
        ));
  }
}
