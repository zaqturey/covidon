import 'package:covidon/enums/endpoint.dart';
import 'package:flutter/foundation.dart';

// ====----Model Class----====
// Below class provides a MAP model where 'Key = Endpoint' and 'Value = int'
class EndpointsData {
  EndpointsData({@required this.values});
  final Map<Endpoint, int> values;

  // ====----Optional Step----====
  // As we know all the enums inside 'Endpoint',
  // creating Getters using 'Endpoint' enum values to easily query 'EndpointsData' class
  int get cases => values[Endpoint.cases];
  int get casesSuspected => values[Endpoint.casesSuspected];
  int get casesConfirmed => values[Endpoint.casesConfirmed];
  int get deaths => values[Endpoint.deaths];
  int get recovered => values[Endpoint.recovered];

  // ====----Optional Step----====
  // Using 'toString()' to get/print debugging information about an 'EndpointsData' object
  @override
  String toString() {
    return 'cases : $cases, casesSuspected: $casesSuspected, casesConfirmed: $casesConfirmed, deaths: $deaths, recovered: $recovered';
  }
}
