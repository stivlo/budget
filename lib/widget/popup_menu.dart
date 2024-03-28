import 'package:budget/screen/default_currency_screen.dart';
import 'package:flutter/material.dart';

import '../shared/menu_action.dart';

class PopupMenu extends StatelessWidget {
  const PopupMenu({super.key});

  static const List<MenuOption> menuOptions = [
    MenuOption(
      'Create New Expense Category',
      MenuAction.newExpenseCategory,
      Icons.output_rounded,
      Colors.deepOrange,
    ),
    MenuOption(
      'Change Default Currency',
      MenuAction.setDefaultCurrency,
      Icons.currency_exchange,
      Colors.grey,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: (selectedValue) {
        switch (selectedValue) {
          case MenuAction.newExpenseCategory:
            break;
          case MenuAction.setDefaultCurrency:
            Navigator.of(context).pushNamed(DefaultCurrencyScreen.routeName);
            break;
          default:
        }
      },
      icon: const Icon(
        Icons.menu,
        color: Colors.white,
      ),
      itemBuilder: (ctx) => buildPopupMenuItems(),
    );
  }

  List<PopupMenuItem<MenuAction>> buildPopupMenuItems() => menuOptions
      .map(
        (e) => PopupMenuItem<MenuAction>(
          value: e.action,
          child: Row(
            children: [
              Icon(
                e.icon,
                color: e.color,
              ),
              const SizedBox(width: 10),
              Text(e.label)
            ],
          ),
        ),
      )
      .toList();
}

class MenuOption {
  const MenuOption(this.label, this.action, this.icon, this.color);

  final String label;
  final MenuAction action;
  final IconData icon;
  final MaterialColor color;
}
