import 'package:covidon/enums/endpoint.dart';
import 'package:covidon/services/api_keys.dart';
import 'package:flutter/foundation.dart';

class APIEndpoint {
  final String apiKey;
  APIEndpoint({@required this.apiKey});

  factory APIEndpoint.sandboxV1() => APIEndpoint(apiKey: APIKeys.ncovApiV1SandboxKey);

  static final String host = 'apigw.nubentos.com';
  static final int port = 443;
  static final String basePath = 't/nubentos.com/ncovapi';
  static final String apiVersionV1 = '1.0.0';

  // As API has multiple Endpoints, Created below MAP for easy accessibility i.e.
  // to use the Endpoint in generating the correct URI in 'getEndpointUriNcovV1' method.
  static Map<Endpoint, String> _paths = {
    Endpoint.cases: 'cases',
    Endpoint.casesSuspected: 'cases/suspected',
    Endpoint.casesConfirmed: 'cases/confirmed',
    Endpoint.deaths: 'deaths',
    Endpoint.recovered: 'recovered',
  };

  Uri getTokenUri() => Uri(
        scheme: 'https',
        host: host,
        port: port,
        path: 'token',
        queryParameters: {'grant_type': 'client_credentials'},
      );

  Uri getEndpointUriNcovV1(Endpoint endpoint) => Uri(
        scheme: 'https',
        host: host,
        port: port,
        path: '$basePath/$apiVersionV1/${_paths[endpoint]}',
      );
}
