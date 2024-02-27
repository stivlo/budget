import 'package:intl/intl.dart';

class DateHelper {
  static String formattedDate() {
    return DateFormat.MMMMEEEEd().format(DateTime.now());
  }
}
