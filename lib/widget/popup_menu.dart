import 'package:budget/screen/currency_screen.dart';
import 'package:flutter/material.dart';

import '../shared/my_actions.dart';

class PopupMenu extends StatelessWidget {
  const PopupMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: (selectedValue) {
        switch (selectedValue) {
          case MyActions.newExpenseCategory:
            break;
          case MyActions.setDefaultCurrency:
            Navigator.of(context).pushNamed(CurrencyScreen.routeName);
            break;
        }
      },
      icon: const Icon(
        Icons.menu,
        color: Colors.white,
      ),
      itemBuilder: (ctx) => [
        const PopupMenuItem(
          value: MyActions.newExpenseCategory,
          child: Row(
            children: [
              Icon(
                Icons.output_rounded,
                color: Colors.deepOrange,
              ),
              SizedBox(width: 10),
              Text('New Expense Category')
            ],
          ),
        ),
        const PopupMenuItem(
          value: MyActions.setDefaultCurrency,
          child: Row(
            children: [
              Icon(
                Icons.currency_exchange,
                color: Colors.deepOrange,
              ),
              SizedBox(width: 10),
              Text('Default Currency')
            ],
          ),
        ),
      ],
    );
  }
}
