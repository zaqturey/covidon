import 'package:covidon/enums/endpoint.dart';
import 'package:flutter/foundation.dart';

// ====----Model Class----====
// Below class provides a MAP model where 'Key = Endpoint' and 'Value = int'
class EndpointsData {
  EndpointsData({@required this.values});
  final Map<Endpoint, int> values;
}
