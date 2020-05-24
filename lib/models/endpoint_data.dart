import 'package:flutter/foundation.dart';

// ====----Model Class----====
// Below class provides a Custom Data Type i.e. 'EndpointData' which is a combination of 'int' and 'DateTIme' values
class EndpointData {
  EndpointData({@required this.value, this.date}) : assert(value != null);
  final int value;
  final DateTime date;

  @override
  String toString() => 'date: $date, value: $value';
}
