import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddMarkerDialogTitle extends StatelessWidget {
  const AddMarkerDialogTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: EdgeInsets.only(top: 10),
      child: Text(
        textAlign: TextAlign.center,
        "Please choose",
        style: GoogleFonts.staatliches(
          color: Color.fromARGB(255, 14, 37, 36),
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
