import 'package:covidon/repository/data_repository.dart';
import 'package:covidon/services/api_endpoint.dart';
import 'package:covidon/services/api_service.dart';
import 'package:covidon/ui/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

void main() async {
  Intl.defaultLocale = 'en_GB';
  await initializeDateFormatting();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider<DataRepository>(
      create: (_) => DataRepository(apiService: APIService(apiEndpoint: APIEndpoint.sandboxV1())),
      child: MaterialApp(
        title: 'Covid App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Color(0xFF101010),
          cardColor: Color(0xFF222222),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Dashboard(),
      ),
    );
  }
}
