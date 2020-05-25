import 'package:flutter/material.dart';

class LastUpdatedStatusText extends StatelessWidget {
  LastUpdatedStatusText({Key key, @required this.dateText}) : super(key: key);
  final String dateText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        dateText,
        textAlign: TextAlign.center,
      ),
    );
  }
}
