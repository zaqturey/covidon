import 'package:covidon/enums/endpoint.dart';
import 'package:covidon/services/api_service.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class DataRepository {
  // ====----Presentation Component----====
  // Purpose of this class is:
  // 1. To provide the requested data to the UI Components by
  // 2. Querying the 'Domain Layer' i.e. 'APIService', based on the passed in API 'Endpoint'

  // Class Constructor that takes 'apiService' as a required parameter
  DataRepository({@required this.apiService});
  final APIService apiService;

  String _accessToken;

  // 'getEndpointDataApiV1' method Queries the 'apiService' to
  // 1. get the 'AccessToken' (only if 'AccessToken' is NULL or if its expired)
  // 2. get data from the passed in 'Endpoint' based on the 'AccessToken' retrieved above
  // 3. Return the result received querying the 'Endpoint'
  // 4. Implement Error Handling
  Future<int> getEndpointDataApiV1(Endpoint endpoint) async {
    try {
      if (_accessToken == null) {
        _accessToken = await apiService.getAccessToken();
      }
      return await apiService.getEndpointDataApiV1(accessToken: _accessToken, endpoint: endpoint);
    } on Response catch (response) {
      if (response.statusCode == 401) {
        _accessToken = await apiService.getAccessToken();
        return await apiService.getEndpointDataApiV1(accessToken: _accessToken, endpoint: endpoint);
      }
      rethrow;
    }
  }
}
