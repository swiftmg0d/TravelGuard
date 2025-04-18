import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class DestinationReachedDialoglogo extends StatelessWidget {
  const DestinationReachedDialoglogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 10, right: 20),
        child: SizedBox(
            height: 220,
            width: 200,
            child: Lottie.asset(
              'assets/icons_json/destination_reached_logo.json',
              fit: BoxFit.cover,
            )),
      ),
    );
  }
}
