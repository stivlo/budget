import 'package:flutter/material.dart';

class DateRange {
  DateRange({this.durationDays = 30, DateTime? endDate})
      : endDate = pickProvidedDateOrNow(endDate);

  int durationDays;
  DateTime endDate;

  static pickProvidedDateOrNow(DateTime? dateTime) {
    if (dateTime == null) {
      return DateUtils.dateOnly(DateTime.now());
    }
    return DateUtils.dateOnly(dateTime);
  }

  DateTime get beginDate => endDate.subtract(Duration(days: durationDays));

  DateRange get withPreviousRange => DateRange(
      durationDays: durationDays,
      endDate: endDate.subtract(Duration(days: durationDays)));

  DateRange get withNextRange => DateRange(
      durationDays: durationDays, endDate: endDate.add(Duration(days: durationDays)));

  DateRange withDurationDays(int durationDays) =>
      DateRange(durationDays: durationDays, endDate: endDate);

  DateRange endingToday(int durationDays) =>
      DateRange(durationDays: durationDays, endDate: DateTime.now());

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is DateRange) {
      return durationDays == other.durationDays && endDate == other.endDate;
    }
    return false;
  }

  @override
  int get hashCode => durationDays.hashCode ^ endDate.hashCode;

  @override
  String toString() =>
      'DateRange{durationDays: $durationDays, beginDate: $beginDate, endDate: $endDate}';
}
