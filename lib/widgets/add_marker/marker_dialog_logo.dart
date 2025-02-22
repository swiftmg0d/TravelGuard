import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AddMarkerDialogLogo extends StatelessWidget {
  const AddMarkerDialogLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      height: 300,
      color: const Color.fromARGB(255, 244, 251, 250),
      child: Opacity(
        opacity: 1,
        child: Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Center(
              child: Lottie.asset(
            'assets/icons_json/marker_confirm_logo.json',
            width: 200,
            height: 200,
            fit: BoxFit.fill,
          )),
        ),
      ),
    );
  }
}
