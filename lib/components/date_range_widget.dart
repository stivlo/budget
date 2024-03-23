import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helper/date_time_helper.dart';
import '../model/date_range.dart';
import '../provider/date_range_provider.dart';

class DateRangeComponent extends StatefulWidget {
  const DateRangeComponent({super.key});

  @override
  State<DateRangeComponent> createState() => _DateRangeComponentState();
}

class _DateRangeComponentState extends State<DateRangeComponent> {
  DateRange dateRange = DateRange();

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 2,
        surfaceTintColor: const Color(0xFFFFE5E5),
        color: Colors.white70,
        margin: const EdgeInsets.all(3),
        child: Consumer<DateRangeProvider>(
            builder: (ctx, dateRangeProvider, _) => Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        buildDropdownMenu(dateRangeProvider),
                        buildTodayButton(dateRangeProvider),
                        const SizedBox(width: 15)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buildPreviousButton(dateRangeProvider),
                        ...buildDateRange(dateRangeProvider),
                        buildNextButton(dateRangeProvider),
                      ],
                    ),
                  ],
                )));
  }

  List<Widget> buildDateRange(DateRangeProvider dateRangeProvider) => [
        Text(DateTimeHelper.formattedShortDate(dateRange.beginDate)),
        const Text('➜'),
        Text(
          DateTimeHelper.formattedShortDate(dateRange.endDate),
          style: TextStyle(
              fontWeight: DateUtils.isSameDay(
            dateRange.endDate,
            DateTimeHelper.todayDate(),
          )
                  ? FontWeight.bold
                  : FontWeight.normal),
        )
      ];

  Widget buildPreviousButton(DateRangeProvider dateRangeProvider) => TextButton(
        onPressed: () {
          setState(() {
            dateRange = dateRangeProvider.previousRange;
          });
        },
        child: const Text('◀'),
      );

  Widget buildNextButton(DateRangeProvider dateRangeProvider) => TextButton(
        onPressed: () {
          setState(() {
            dateRange = dateRangeProvider.nextRange;
          });
        },
        child: const Text('▶'),
      );

  Widget buildTodayButton(DateRangeProvider dateRangeProvider) => TextButton(
        onPressed: () => setState(() {
          dateRange = dateRangeProvider.endingToday();
        }),
        child: Text(
          '📅Today',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      );

  DropdownMenu<int> buildDropdownMenu(DateRangeProvider dateRangeProvider) =>
      DropdownMenu<int>(
        initialSelection: 30,
        requestFocusOnTap: false,
        enableSearch: false,
        enableFilter: false,
        textStyle: const TextStyle(fontSize: 12),
        width: 110,
        inputDecorationTheme: InputDecorationTheme(
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 4),
          constraints: BoxConstraints.tight(const Size.fromHeight(32)),
          border: InputBorder.none,
        ),
        onSelected: (durationDays) {
          if (durationDays != null) {
            setState(() {
              dateRange = dateRangeProvider.withDurationDays(durationDays);
            });
          }
        },
        menuStyle: MenuStyle(
          surfaceTintColor: MaterialStateProperty.resolveWith((states) => Colors.white),
        ),
        dropdownMenuEntries: buildDropDownMenuEntries(),
      );

  List<DropdownMenuEntry<int>> buildDropDownMenuEntries() => [7, 15, 30, 60, 90, 180, 365]
      .map<DropdownMenuEntry<int>>(
        (int days) => DropdownMenuEntry<int>(
            value: days,
            label: '$days days',
            style: ButtonStyle(
              backgroundColor: MaterialStateColor.resolveWith((states) => Colors.white),
              textStyle: MaterialStateTextStyle.resolveWith(
                (states) => const TextStyle(fontSize: 12),
              ),
            )),
      )
      .toList();
}
