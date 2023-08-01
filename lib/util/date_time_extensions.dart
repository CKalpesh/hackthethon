import 'package:intl/intl.dart';

extension ParseDateTime on DateTime {
  String dayMonthYear() {
    return DateFormat('dd/MM/yyyy').format(this);
  }
}
