import 'package:covidon/enums/endpoint.dart';
import 'package:covidon/repository/endpoints_data.dart';
import 'package:covidon/services/api_service.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

// ====----Presentation Component----====
// Purpose of this class is:
// 1. To provide the requested data to the UI Components by
// 2. Querying the 'Domain Layer' i.e. 'APIService', based on the passed in API 'Endpoint'

class DataRepository {
  // Class Constructor that takes 'apiService' as a required parameter
  DataRepository({@required this.apiService});
  final APIService apiService;

  String _accessToken;

  // Method to get the Result for a Single Endpoint
  Future<int> getEndpointDataApiV1(Endpoint endpoint) async => await _getDataRefreshingToken<int>(
        onGetData: () => apiService.getEndpointDataApiV1(accessToken: _accessToken, endpoint: endpoint),
      );

  // Method to get the Results for ALL the Endpoints
  Future<EndpointsData> getAllEndpointDataApiV1() async => await _getDataRefreshingToken<EndpointsData>(
        onGetData: _getAllEndpointDataApiV1,
      );

  // function '_getDataRefreshingToken' accepts another 'Function()' as its parameter, which will return a Future<T>
  Future<T> _getDataRefreshingToken<T>({Future<T> Function() onGetData}) async {
    try {
      if (_accessToken == null) {
        _accessToken = await apiService.getAccessToken();
      }
      return await onGetData();
    } on Response catch (response) {
      if (response.statusCode == 401) {
        _accessToken = await apiService.getAccessToken();
        return await onGetData();
      }
      rethrow;
    }
  }

  // Below method will PARALLELY fetch the Data from all the Endpoints and
  // Using 'Future.wait()' we will add the each response into a temp List
  Future<EndpointsData> _getAllEndpointDataApiV1() async {
    // Below will get a 'List<int>' i.e. endpointsValues
    final endpointsValues = await Future.wait([
      apiService.getEndpointDataApiV1(accessToken: _accessToken, endpoint: Endpoint.cases),
      apiService.getEndpointDataApiV1(accessToken: _accessToken, endpoint: Endpoint.casesSuspected),
      apiService.getEndpointDataApiV1(accessToken: _accessToken, endpoint: Endpoint.casesConfirmed),
      apiService.getEndpointDataApiV1(accessToken: _accessToken, endpoint: Endpoint.deaths),
      apiService.getEndpointDataApiV1(accessToken: _accessToken, endpoint: Endpoint.recovered),
    ]);
    return EndpointsData(values: {
      Endpoint.cases: endpointsValues[0],
      Endpoint.casesSuspected: endpointsValues[1],
      Endpoint.casesConfirmed: endpointsValues[2],
      Endpoint.deaths: endpointsValues[3],
      Endpoint.recovered: endpointsValues[4],
    });
  }
}
