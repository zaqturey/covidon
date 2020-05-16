import 'package:covidon/enums/endpoint.dart';
import 'package:covidon/services/api_endpoint.dart';
import 'package:covidon/services/api_service.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _accessToken = '';
  int _cases;
  int _recovered;

  void _updateAccessToken() async {
    final apiService = APIService(apiEndpoint: APIEndpoint.sandboxV1());
    final accessToken = await apiService.getAccessToken();
    final cases = await apiService.getEndpointDataApiV1(accessToken: accessToken, endpoint: Endpoint.cases);
    final recovered = await apiService.getEndpointDataApiV1(accessToken: accessToken, endpoint: Endpoint.recovered);
    setState(() {
      _accessToken = accessToken;
      _cases = cases;
      _recovered = recovered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_accessToken',
              style: Theme.of(context).textTheme.headline4,
            ),
            // Since initial value for '_cases' will be NULL,
            // therefore using 'Collection-If' for NULL Check, and only displaying the 'Text' if its not NULL.
            if (_cases != null)
              Text(
                'Cases: $_cases',
                style: Theme.of(context).textTheme.headline4,
              ),
            if (_recovered != null)
              Text(
                'Recovered: $_recovered',
                style: Theme.of(context).textTheme.headline4,
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _updateAccessToken,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
