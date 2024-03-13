import 'package:budget/helper/date_time_helper.dart';
import 'package:budget/widget/cron_test.dart';
import 'package:budget/widget/expenses_home.dart';
import 'package:budget/widget/income_home.dart';
import 'package:flutter/material.dart';

import '../provider/currency_provider.dart';
import '../widget/popup_menu.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen(this.currencyProvider, {super.key});

  static const routeName = '/';

  final CurrencyProvider currencyProvider;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const PopupMenu(),
          title: Text(DateTimeHelper.formattedDate()),
          centerTitle: true,
        ),
        body: const SingleChildScrollView(
          child: Column(
            children: [
              IncomeHome(),
              ExpensesHome(),
              CronTest(),
            ],
          ),
        ));
  }
}
