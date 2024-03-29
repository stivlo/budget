import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeHelper {
  static String formattedLongDateNow() => formattedLongDate(DateTime.now());

  static String formattedLongDate(DateTime date) => DateFormat.MMMMEEEEd().format(date);

  static String formattedShortDate(DateTime date) {
    final formatter = DateFormat('E, d MMM yy');
    return formatter.format(date);
  }

  static String formattedIsoDate(DateTime date) =>
      date.toIso8601String().substring(0, 10);

  static String formattedTime() => DateFormat.Hms().format(DateTime.now());

  static DateTime todayDate() => DateUtils.dateOnly(DateTime.now());
}
