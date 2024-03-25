import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../helper/date_time_helper.dart';
import '../model/date_range.dart';

class DateRangeNotifier extends StateNotifier<DateRange> {
  DateRangeNotifier()
      : super(
          DateRange(
            durationDays: 30,
            endDate: DateTimeHelper.todayDate(),
          ),
        );

  DateRange moveToNext() {
    state = state.withNextRange;
    return state;
  }

  DateRange moveToPrevious() {
    state = state.withPreviousRange;
    return state;
  }

  DateRange moveToDurationDays(int durationDays) {
    state = state.withDurationDays(durationDays);
    return state;
  }

  DateRange moveToEndingToday() {
    state = state.endingToday(state.durationDays);
    return state;
  }
}

final dateRangeProvider = StateNotifierProvider<DateRangeNotifier, DateRange>(
  (ref) => DateRangeNotifier(),
);
