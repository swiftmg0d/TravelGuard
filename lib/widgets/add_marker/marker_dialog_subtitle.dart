import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddMarkerDialogSubTitle extends StatelessWidget {
  const AddMarkerDialogSubTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: EdgeInsets.only(top: 35),
      child: Text(
        textAlign: TextAlign.center,
        "the radius of the area",
        style: GoogleFonts.staatliches(
          color: Color.fromARGB(255, 14, 37, 36),
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
