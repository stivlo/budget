import 'package:budget/helper/date_time_helper.dart';
import 'package:budget/model/date_range.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late DateRange dateRange;

  group('initial default values', () {
    setUp(() {
      dateRange = DateRange();
    });

    test('initial default duration is set to 30 days', () {
      expect(dateRange.durationDays, 30);
    });

    test('initial default endDate is set to today', () {
      var now = DateTime.now();
      var lastMidnight = DateTime(now.year, now.month, now.day);
      expect(dateRange.endDate, lastMidnight);
    });

    test('initial default beginDate is set to 30 days before today', () {
      expect(
        DateTimeHelper.formattedIsoDate(dateRange.beginDate),
        DateTimeHelper.formattedIsoDate(
          dateRange.endDate.subtract(const Duration(days: 30)),
        ),
      );
    });
  });

  group('custom initial values', () {
    setUp(() {
      dateRange = DateRange(durationDays: 7, endDate: DateTime.parse('2024-03-14'));
    });

    test('can set durationDays to 7', () {
      expect(dateRange.durationDays, 7);
    });

    test('can set endDate to the provided date', () {
      expect(dateRange.endDate, DateTime.parse('2024-03-14'));
    });

    test('beginDate will be 7 days before the endDate as requested', () {
      expect(dateRange.beginDate, DateTime.parse('2024-03-07'));
    });
  });

  group('going back and forward in time and changing durationDays', () {
    setUp(() {
      dateRange = DateRange(durationDays: 7, endDate: DateTime.parse('2024-03-12'));
    });

    test('can go back in time by one period', () {
      expect(dateRange.withPreviousRange,
          DateRange(durationDays: 7, endDate: DateTime.parse('2024-03-05')));
    });

    test('can go forward in time', () {
      expect(dateRange.withNextRange,
          DateRange(durationDays: 7, endDate: DateTime.parse('2024-03-19')));
    });

    test('can change durationDays from 7 to 30', () {
      expect(dateRange.withDurationDays(30),
          DateRange(durationDays: 30, endDate: DateTime.parse('2024-03-12')));
    });
  });
}
