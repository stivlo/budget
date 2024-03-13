import 'package:flutter/material.dart';

import 'circle_icon.dart';

class ExpensesHome extends StatelessWidget {
  const ExpensesHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: const CircleIcon(Icons.output_rounded, Colors.orange),
            title: Text('Expenses', style: Theme.of(context).textTheme.titleLarge),
            trailing: Text('30 days ▼', style: Theme.of(context).textTheme.titleMedium),
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
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 18),
            child: Text('◀ Friday, 16 February  →  Thursday, 22 February ▶'),
          ),
          const SizedBox(height: 20),
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
