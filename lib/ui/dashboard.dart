import 'package:covidon/enums/endpoint.dart';
import 'package:covidon/repository/data_repository.dart';
import 'package:covidon/repository/endpoints_data.dart';
import 'package:covidon/ui/endpoint_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  EndpointsData _endpointsData;

  // Calling '_updateData()' each time the App starts, as 'Dashboard()' will be called on App Start.
  @override
  void initState() {
    super.initState();
    _updateData();
  }

  Future<void> _updateData() async {
    final dataRepository = Provider.of<DataRepository>(context, listen: false);
    final endpointsData = await dataRepository.getAllEndpointDataApiV1();
    setState(() => _endpointsData = endpointsData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Covidon")),
      body: ListView(
        children: <Widget>[
          for (var endpoint in Endpoint.values)
            EndpointCard(
              endpoint: endpoint,
              value: _endpointsData != null ? _endpointsData.values[endpoint] : null,
            )
        ],
      ),
    );
  }
}
