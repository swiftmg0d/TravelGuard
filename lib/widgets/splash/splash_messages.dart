import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_guard/constants/messsages.dart';

class SplashMessages extends StatelessWidget {
  final int currentIndex;
  final bool isLoaded;

  const SplashMessages({
    super.key,
    required this.currentIndex,
    required this.isLoaded,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          width: 280,
          child: Text(
            LoadingMessages.messages[currentIndex],
            key: ValueKey<int>(currentIndex),
            textAlign: TextAlign.center,
            style: GoogleFonts.staatliches(
              color: Color.fromARGB(255, 29, 78, 74),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
