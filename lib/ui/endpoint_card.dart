import 'package:covidon/enums/endpoint.dart';
import 'package:covidon/models/endpoint_card_data.dart';
import 'package:covidon/utils/number_formatter.dart';
import 'package:flutter/material.dart';

// ====----Custom Widget----====
class EndpointCard extends StatelessWidget {
  EndpointCard({Key key, this.endpoint, this.value});
  final Endpoint endpoint;
  final int value;

  static Map<Endpoint, EndpointCardData> _cardData = {
    Endpoint.cases: EndpointCardData('cases', 'assets/count.png', Color(0xFFFFF492)),
    Endpoint.casesSuspected: EndpointCardData('cases/suspected', 'assets/suspect.png', Color(0xFFEEDA28)),
    Endpoint.casesConfirmed: EndpointCardData('cases/confirmed', 'assets/fever.png', Color(0xFFE99600)),
    Endpoint.deaths: EndpointCardData('deaths', 'assets/death.png', Color(0xFFE40000)),
    Endpoint.recovered: EndpointCardData('recovered', 'assets/patient.png', Color(0xFF70A901)),
  };

  String get formattedValue {
    return NumberFormatter(numberToFormat: value).formatNumber();
  }

  @override
  Widget build(BuildContext context) {
    final cardData = _cardData[endpoint];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cardData.title,
                style: Theme.of(context).textTheme.headline5.copyWith(color: cardData.cardColor),
              ),
              SizedBox(height: 4),
              SizedBox(
                height: 52,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      cardData.assetName,
                      color: cardData.cardColor,
                    ),
                    Text(
                      formattedValue,
                      style: Theme.of(context).textTheme.headline4.copyWith(
                            color: cardData.cardColor,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
