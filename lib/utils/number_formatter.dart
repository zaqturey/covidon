import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

// Below call add a Thousand separator to the passed in Number and returns that as a String.
class NumberFormatter {
  NumberFormatter({@required this.numberToFormat});
  final int numberToFormat;

  String formatNumber() {
    if (numberToFormat == null) {
      return '';
    }
    return NumberFormat('#,###,###,###').format(numberToFormat);
  }
}
