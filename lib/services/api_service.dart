import 'dart:convert';

import 'package:covidon/enums/endpoint.dart';
import 'package:covidon/models/endpoint_data.dart';
import 'package:covidon/services/api_endpoint.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class APIService {
  APIService({@required this.apiEndpoint});
  final APIEndpoint apiEndpoint;

  // As KEY names are different in different endpoint responses,
  // below Map will dynamically resolve the correct KEY for a given Endpoint
  static Map<Endpoint, String> _responseJsonKeys = {
    Endpoint.cases: 'cases',
    Endpoint.casesSuspected: 'data',
    Endpoint.casesConfirmed: 'data',
    Endpoint.deaths: 'data',
    Endpoint.recovered: 'data',
  };

  Future<String> getAccessToken() async {
    final tokenUri = apiEndpoint.getTokenUri();
    final response = await http.post(
      tokenUri.toString(),
      headers: {'Authorization': 'Basic ${apiEndpoint.apiKey}'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final accessToken = data['access_token'];
      if (accessToken != null) {
        return accessToken;
      }
    }
    print('Request: ${apiEndpoint.getTokenUri()} failed \nResponse: ${response.statusCode} ${response.reasonPhrase}');
    throw response;
  }

  Future<EndpointData> getEndpointDataApiV1({@required String accessToken, @required Endpoint endpoint}) async {
    // Fetching the Uri for a given Endpoint
    final endpointUri = apiEndpoint.getEndpointUriNcovV1(endpoint);
    // Fetching the HTTP Response by Making an HTTP (get) request using the above Uri
    final response = await http.get(
      endpointUri.toString(),
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    // Processing the Response
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      if (data.isNotEmpty) {
        // Fetching the First Item from the JSON response which is a 'List<dynamic>'
        // and assigning each of the 'Key-Value' pair present in the First Item, into a MAP
        final Map<String, dynamic> endpointData = data[0];
        // As required KEY name is different for different Endpoints, getting the correct KEY name for the Endpoint.
        final responseJsonKey = _responseJsonKeys[endpoint];
        final int countValue = endpointData[responseJsonKey];
        // Getting the value associated with 'date' key
        final String dateString = endpointData['date'];
        // parsing the date using 'tryParse' rather than 'parse'
        // 'tryParse' doesn't throw error if the input String can't be parsed and instead returns null
        final date = DateTime.tryParse(dateString);
        if (countValue != null) {
          return EndpointData(value: countValue, date: date);
        }
      }
    }
    print('Request $endpointUri failed \nResponse: ${response.statusCode} ${response.reasonPhrase}');
    throw response;
  }
}
