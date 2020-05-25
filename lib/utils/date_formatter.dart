import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateFormatter {
  DateFormatter({@required this.dateToFormat});
  final DateTime dateToFormat;

  String formatDate() {
    if (dateToFormat != null) {
      final formatter = DateFormat.yMd().add_Hms();
      final formattedDate = formatter.format(dateToFormat);
      return formattedDate;
    }
    return '';
  }
}
