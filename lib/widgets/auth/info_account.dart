import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoAccount extends StatelessWidget {
  final String text1;
  final String text2;
  final String screen;
  const InfoAccount({
    super.key,
    r,
    required this.text1,
    required this.text2,
    required this.screen,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(text1, style: GoogleFonts.staatliches(color: Color.fromARGB(255, 25, 67, 64), fontSize: 20)),
        InkWell(
            child: Text(text2, style: GoogleFonts.staatliches(color: Color.fromARGB(255, 16, 44, 43), fontSize: 20, fontWeight: FontWeight.bold)),
            onTap: () {
              Navigator.pushNamed(context, screen);
            }),
      ],
    );
  }
}
