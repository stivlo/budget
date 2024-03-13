import 'package:intl/intl.dart';

class DateTimeHelper {
  static String formattedDate() => DateFormat.MMMMEEEEd().format(DateTime.now());

  static String formattedTime() => DateFormat.Hms().format(DateTime.now());
}
