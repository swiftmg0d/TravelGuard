import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LogOutDialogLogo extends StatelessWidget {
  const LogOutDialogLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 60, left: 50),
      child: Lottie.asset(
        'assets/icons_json/logout_logo.json',
        width: 200,
        height: 200,
        fit: BoxFit.fill,
      ),
    );
  }
}
