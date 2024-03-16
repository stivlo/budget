import 'package:flutter/material.dart';

class DateRange {
  DateRange({this.durationDays = 30, DateTime? endDate})
      : endDate = endDate ?? DateUtils.dateOnly(DateTime.now());

  int durationDays;
  DateTime endDate;

  DateTime get beginDate => endDate.subtract(Duration(days: durationDays));

  DateRange get withPreviousRange => DateRange(
      durationDays: durationDays,
      endDate: endDate.subtract(Duration(days: durationDays)));

  DateRange get withNextRange => DateRange(
      durationDays: durationDays, endDate: endDate.add(Duration(days: durationDays)));

  DateRange withDurationDays(int durationDays) =>
      DateRange(durationDays: durationDays, endDate: endDate);

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
