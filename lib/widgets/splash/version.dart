import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Version extends StatelessWidget {
  const Version({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 25,
          height: 25,
          decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle),
          child: Center(
            child: Text(
              "!",
              style: GoogleFonts.staatliches(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SizedBox(width: 5),
        Text(
          "version beta",
          style: GoogleFonts.staatliches(
            color: Color.fromARGB(255, 19, 52, 50),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}
