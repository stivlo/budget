import 'package:flutter/material.dart';

import '../component/accounts_home.dart';
import '../component/date_range_component.dart';
import '../component/expenses_home.dart';
import '../component/income_home.dart';
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
