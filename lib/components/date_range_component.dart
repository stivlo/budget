import 'package:budget/provider/date_range_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../helper/date_time_helper.dart';
import '../model/date_range.dart';

class DateRangeComponent extends ConsumerWidget {
  const DateRangeComponent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DateRange dateRange = ref.watch(dateRangeProvider);
    return Card(
      elevation: 2,
      surfaceTintColor: const Color(0xFFFFE5E5),
      color: Colors.white70,
      margin: const EdgeInsets.all(3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              buildDurationDaysDropdown(dateRange, ref),
              buildTodayButton(ref, context),
              const SizedBox(width: 15)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildPreviousButton(ref),
              ...buildDateRange(dateRange),
              buildNextButton(ref),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> buildDateRange(DateRange dateRange) => [
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

  Widget buildPreviousButton(WidgetRef ref) => TextButton(
        onPressed: () => ref.read(dateRangeProvider.notifier).moveToPrevious(),
        child: const Text('◀'),
      );

  Widget buildNextButton(WidgetRef ref) => TextButton(
        onPressed: () => ref.read(dateRangeProvider.notifier).moveToNext(),
        child: const Text('▶'),
      );

  Widget buildTodayButton(WidgetRef ref, BuildContext context) => TextButton(
        onPressed: () => ref.read(dateRangeProvider.notifier).moveToEndingToday(),
        child: Text('📅 Today', style: Theme.of(context).textTheme.bodySmall),
      );

  DropdownMenu<int> buildDurationDaysDropdown(DateRange dateRange, WidgetRef ref) =>
      DropdownMenu<int>(
        initialSelection: dateRange.durationDays,
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
            ref.read(dateRangeProvider.notifier).moveToDurationDays(durationDays);
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
