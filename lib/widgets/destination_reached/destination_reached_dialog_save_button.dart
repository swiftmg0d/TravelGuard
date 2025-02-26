import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DestinationReachedDialogSaveButton extends StatelessWidget {
  const DestinationReachedDialogSaveButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Container(
        width: 100,
        padding: EdgeInsets.symmetric(vertical: 3, horizontal: 20),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 18, 68, 64),
          border: Border.all(color: Color.fromARGB(255, 16, 44, 43), width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          textAlign: TextAlign.center,
          "Save",
          style: GoogleFonts.staatliches(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
