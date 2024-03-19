import 'package:budget/helper/date_time_helper.dart';
import 'package:budget/provider/date_range_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/date_range.dart';

class DateRangeWidget extends StatefulWidget {
  const DateRangeWidget({super.key});

  @override
  State<DateRangeWidget> createState() => _DateRangeWidgetState();
}

class _DateRangeWidgetState extends State<DateRangeWidget> {
  DateRange dateRange = DateRange();

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        surfaceTintColor: const Color(0xFFFFE5E5),
        color: Colors.white,
        child: Consumer<DateRangeProvider>(
            builder: (ctx, dateRangeProvider, _) => Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        buildDropdownMenu(dateRangeProvider),
                        TextButton(
                          onPressed: () => setState(() {
                            dateRange = dateRangeProvider.endingToday();
                          }),
                          child: Text(
                            '📅Today',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                        const SizedBox(width: 15)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                            onPressed: () {
                              setState(() {
                                dateRange = dateRangeProvider.previousRange;
                              });
                            },
                            child: const Text('◀')),
                        Text(DateTimeHelper.formattedShortDate(dateRange.beginDate)),
                        const Text('➜'),
                        Text(
                          DateTimeHelper.formattedShortDate(dateRange.endDate),
                          style: TextStyle(
                              fontWeight: DateUtils.isSameDay(
                            dateRange.endDate,
                            DateTimeHelper.todaysDate(),
                          )
                                  ? FontWeight.bold
                                  : FontWeight.normal),
                        ),
                        TextButton(
                            onPressed: () {
                              setState(() {
                                dateRange = dateRangeProvider.nextRange;
                              });
                            },
                            child: const Text('▶')),
                      ],
                    ),
                  ],
                )));
  }

  DropdownMenu<int> buildDropdownMenu(DateRangeProvider dateRangeProvider) {
    return DropdownMenu<int>(
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
      dropdownMenuEntries: [7, 15, 30, 60, 90, 180, 365]
          .map<DropdownMenuEntry<int>>(
            (int days) => DropdownMenuEntry<int>(
                value: days,
                label: '$days days',
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateColor.resolveWith((states) => Colors.white),
                  textStyle: MaterialStateTextStyle.resolveWith(
                    (states) => const TextStyle(fontSize: 12),
                  ),
                )),
          )
          .toList(),
    );
  }
}
