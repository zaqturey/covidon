import 'dart:io';

import 'package:covidon/enums/endpoint.dart';
import 'package:covidon/models/endpoints_data.dart';
import 'package:covidon/repository/data_repository.dart';
import 'package:covidon/ui/endpoint_card.dart';
import 'package:covidon/ui/show_alert_dialogue.dart';
import 'package:covidon/utils/date_formatter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  EndpointsData _endpointsData;

  // Calling '_updateData()' each time the App starts, as 'Dashboard()' will be called on App Start.
  // App (initState()) will first try to fetch the 'Cached Data' and then make an API request to get the latest Data.
  // Note: Getting data from 'SharedPreferences' is a Synchronous operation that allows us to display data instantly.
  @override
  void initState() {
    super.initState();
    // Getting 'DataRepository' using Provider
    final dataRepository = Provider.of<DataRepository>(context, listen: false);
    // Updating the '_endpointsData' using Cached data.
    _endpointsData = dataRepository.getAllEndpointsCachedData();
    _updateData();
  }

  Future<void> _updateData() async {
    try {
      final dataRepository = Provider.of<DataRepository>(context, listen: false);
      final endpointsData = await dataRepository.getAllEndpointDataApiV1();
      setState(() => _endpointsData = endpointsData);
    } on SocketException catch (_) {
      showAlertDialogue(
        context: context,
        title: 'Connection Error',
        content: 'Could not retrieve data. Please try again later.',
        defaultActionText: 'OK',
      );
    } catch (_) {
      showAlertDialogue(
        context: context,
        title: 'Unknown Error',
        content: 'Please contact support or try again later.',
        defaultActionText: 'OK',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormatter(
      dateToFormat: _endpointsData != null ? _endpointsData.values[Endpoint.cases]?.date : null,
    ).formatDate();

    return Scaffold(
      appBar: AppBar(title: Text("Covidon")),
      body: RefreshIndicator(
        onRefresh: _updateData,
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Last updated: $formattedDate',
                textAlign: TextAlign.center,
              ),
            ),
            for (var endpoint in Endpoint.values)
              EndpointCard(
                endpoint: endpoint,
                value: _endpointsData != null ? _endpointsData.values[endpoint]?.value : null,
              )
          ],
        ),
      ),
    );
  }
}
