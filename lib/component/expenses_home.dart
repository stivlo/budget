import 'package:flutter/material.dart';

import '../helper/themes.dart';
import '../widget/circle_icon.dart';

class ExpensesHome extends StatelessWidget {
  const ExpensesHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ListTile(
            leading: CircleIcon(Icons.output_rounded, Colors.orange),
            title: Text('Expenses', style: Themes.titleLarge),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 18),
            child: Row(
              children: [
                Text('Available today: '),
                Text(' £112.12',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: TextButton(
                onPressed: () {},
                child: const Text('No expense categories yet'),
              )),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
