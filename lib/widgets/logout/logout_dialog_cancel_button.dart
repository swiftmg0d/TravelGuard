import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LogOutDialogCancelButton extends StatelessWidget {
  const LogOutDialogCancelButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.of(context).pop(),
      child: Container(
        padding: EdgeInsets.only(top: 3, bottom: 3, left: 20, right: 20),
        decoration: BoxDecoration(
          border: Border.all(color: Color.fromARGB(255, 16, 44, 43), width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text("Cancel",
            style: GoogleFonts.staatliches(
              color: Color.fromARGB(255, 29, 78, 74),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )),
      ),
    );
  }
}
