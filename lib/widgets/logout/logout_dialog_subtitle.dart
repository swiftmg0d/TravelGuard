import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LogOutDialogSubTitle extends StatelessWidget {
  const LogOutDialogSubTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: EdgeInsets.only(top: 40),
      child: Text(
        textAlign: TextAlign.center,
        "you want to logout?",
        style: GoogleFonts.staatliches(
          color: Color.fromARGB(255, 14, 37, 36),
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
