import 'package:covidon/services/api_keys.dart';
import 'package:flutter/foundation.dart';

class APIEndpoint {
  final String apiKey;
  APIEndpoint({@required this.apiKey});

  factory APIEndpoint.sandboxV1() => APIEndpoint(apiKey: APIKeys.ncovApiV1SandboxKey);

  static final String host = 'apigw.nubentos.com';
  static final int port = 443;

  Uri getTokenUri() => Uri(
        scheme: 'https',
        host: host,
        port: port,
        path: 'token',
        queryParameters: {'grant_type': 'client_credentials'},
      );
}
