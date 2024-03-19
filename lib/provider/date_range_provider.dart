import 'package:budget/helper/date_time_helper.dart';
import 'package:flutter/material.dart';

import '../model/date_range.dart';

class DateRangeProvider with ChangeNotifier {
  DateRangeProvider()
      : dateRange = DateRange(
          durationDays: 30,
          endDate: DateTimeHelper.todaysDate(),
        );

  DateRange dateRange;

  DateRange get range => dateRange;

  DateTime get beginDate => dateRange.beginDate;

  DateTime get endDate => dateRange.endDate;

  int get durationDays => dateRange.durationDays;

  DateRange get nextRange {
    dateRange = dateRange.withNextRange;
    notifyListeners();
    return dateRange;
  }

  DateRange get previousRange {
    dateRange = dateRange.withPreviousRange;
    notifyListeners();
    return dateRange;
  }

  DateRange withDurationDays(int durationDays) {
    dateRange = dateRange.withDurationDays(durationDays);
    notifyListeners();
    return dateRange;
  }

  DateRange endingToday() {
    dateRange = dateRange.endingToday(durationDays);
    notifyListeners();
    return dateRange;
  }
}
