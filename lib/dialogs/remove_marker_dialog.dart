import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RemoveMarkerDialog extends StatefulWidget {
  const RemoveMarkerDialog({super.key});

  @override
  State<RemoveMarkerDialog> createState() => _RemoveMarkerDialogState();
}

class _RemoveMarkerDialogState extends State<RemoveMarkerDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        width: 150,
        child: Text('Are you sure you want to delete this marker?',
            textAlign: TextAlign.center,
            style: GoogleFonts.staatliches(
              color: Color.fromARGB(255, 14, 37, 36),
              fontSize: 19,
              fontWeight: FontWeight.bold,
            )),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: Container(
            width: 100,
            padding: EdgeInsets.symmetric(vertical: 3, horizontal: 20),
            decoration: BoxDecoration(
              border:
                  Border.all(color: Color.fromARGB(255, 16, 44, 43), width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              textAlign: TextAlign.center,
              "Cancel",
              style: GoogleFonts.staatliches(
                color: Color.fromARGB(255, 29, 78, 74),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          child: Container(
            width: 100,
            padding: EdgeInsets.symmetric(vertical: 3, horizontal: 20),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 18, 68, 64),
              border:
                  Border.all(color: Color.fromARGB(255, 16, 44, 43), width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              "Delete",
              textAlign: TextAlign.center,
              style: GoogleFonts.staatliches(
                color: Color.fromARGB(255, 255, 255, 255),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
