import 'package:covidon/enums/endpoint.dart';
import 'package:covidon/models/endpoint_data.dart';
import 'package:covidon/models/endpoints_data.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ====----Service Class----====
// Purpose of this class is to provide methods to Write and Read the data to Shared Preferences
// By default 'SharedPreferences' processes 'primitive' data types,
// To process a Custom data type (i.e. Endpoint), granule it to 'primitive' types, and then process it.
class DataCacheService {
  DataCacheService({@required this.sharedPreferences});
  final SharedPreferences sharedPreferences;

  // Below Functions will return Keys (as String) for the passed in 'Endpoint' (which is an enum)
  static String endpointValueKey(Endpoint endpoint) => '$endpoint/value';
  static String endpointDateKey(Endpoint endpoint) => '$endpoint/date';

  // Writing data To sharedPreferences
  // Note: EndpointsData is a 'Map<Endpoint, EndpointData>'
  // setData will iterate though each item in 'endpointsData' (Map) and store it in 'sharedPreferences' instance.
  Future<void> setData(EndpointsData endpointsData) async {
    endpointsData.values.forEach((endpoint, endpointData) async {
      await sharedPreferences.setInt(
        endpointValueKey(endpoint),
        endpointData.value,
      );
      await sharedPreferences.setString(
        endpointDateKey(endpoint),
        endpointData.date.toIso8601String(),
      );
    });
  }

  // Reading data From sharedPreferences
  EndpointsData getData() {
    Map<Endpoint, EndpointData> spValues = {};
    // Iterating though all enum values in 'Endpoint'
    Endpoint.values.forEach((endpoint) {
      // getting the keys from 'sharedPreferences' for the passed in 'endpoint'
      final valueKey = sharedPreferences.getInt(endpointValueKey(endpoint));
      final dateString = sharedPreferences.getString(endpointDateKey(endpoint));
      if (valueKey != null && dateString != null) {
        final dateKey = DateTime.tryParse(dateString);
        // Adding 'EndpointData' (value) to spValues (Map) for 'endpoint' key
        spValues[endpoint] = EndpointData(value: valueKey, date: dateKey);
      }
    });
    return EndpointsData(values: spValues);
  }
}
