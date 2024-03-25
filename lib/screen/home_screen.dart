import 'package:flutter/material.dart';

import '../components/accounts_home.dart';
import '../components/date_range_component.dart';
import '../components/expenses_home.dart';
import '../components/income_home.dart';
import '../helper/date_time_helper.dart';
import '../widget/popup_menu.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const PopupMenu(),
          title: Text(DateTimeHelper.formattedLongDateNow()),
          centerTitle: true,
        ),
        body: const SingleChildScrollView(
          child: Column(
            children: [
              DateRangeComponent(),
              AccountsHome(),
              IncomeHome(),
              ExpensesHome(),
            ],
          ),
        ));
  }
}
