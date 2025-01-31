import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({
    super.key,
    required int width,
    required int height,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset(
          'assets/icons/logo.png',
          fit: BoxFit.cover,
          width: 320,
          height: 270,
        ),
      ],
    );
  }
}
