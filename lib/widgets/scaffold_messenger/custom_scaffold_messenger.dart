import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomScaffoldMessenger {
  static void show(BuildContext context, String text, Color backgroundColor) {
    ScaffoldMessenger.of(context).showSnackBar(
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
