import 'dart:convert';

import 'package:covidon/services/api_endpoint.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class APIService {
  APIService({@required this.apiEndpoint});
  final APIEndpoint apiEndpoint;

  Future<String> getAccessToken() async {
    final response = await http.post(
      apiEndpoint.getTokenUri().toString(),
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
}
