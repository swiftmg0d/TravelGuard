import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HistoryDetailsLogo extends StatelessWidget {
  const HistoryDetailsLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            margin: EdgeInsets.only(bottom: 510),
            child:
                Lottie.asset("assets/icons_json/history_details_logo.json")));
  }
}
