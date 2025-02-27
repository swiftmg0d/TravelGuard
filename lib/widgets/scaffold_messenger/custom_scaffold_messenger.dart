import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_guard/main.dart';

class CustomScaffoldMessenger {
  static void show(BuildContext context, String text, Color backgroundColor) {
    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        width: 200,
        backgroundColor: backgroundColor,
        content: Text(
          text,
          textAlign: TextAlign.center,
          style: GoogleFonts.staatliches(
            color: const Color.fromARGB(255, 255, 255, 255),
            fontSize: 20,
            fontWeight: FontWeight.w100,
          ),
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
