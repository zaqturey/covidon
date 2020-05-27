import 'package:covidon/repository/data_repository.dart';
import 'package:covidon/services/api_endpoint.dart';
import 'package:covidon/services/api_service.dart';
import 'package:covidon/services/data_cache_service.dart';
import 'package:covidon/ui/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Intl.defaultLocale = 'en_GB';
  await initializeDateFormatting();
  // Getting an instance of 'SharedPreferences' so that we can pass it to the 'Create' method of 'Provider'
  final sharedPreferences = await SharedPreferences.getInstance();
  runApp(MyApp(sharedPreferences: sharedPreferences));
}

class MyApp extends StatelessWidget {
  MyApp({Key key, @required this.sharedPreferences}) : super(key: key);
  final SharedPreferences sharedPreferences;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider<DataRepository>(
      create: (_) => DataRepository(
        apiService: APIService(apiEndpoint: APIEndpoint.sandboxV1()),
        dataCacheService: DataCacheService(sharedPreferences: sharedPreferences),
      ),
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
