import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthInfoAccount extends StatelessWidget {
  final String title;
  final String subtitle;
  final String screen;
  const AuthInfoAccount({
    super.key,
    r,
    required this.title,
    required this.subtitle,
    required this.screen,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(title,
            style: GoogleFonts.staatliches(
                color: Color.fromARGB(255, 25, 67, 64), fontSize: 20)),
        InkWell(
            child: Text(subtitle,
                style: GoogleFonts.staatliches(
                    color: Color.fromARGB(255, 16, 44, 43),
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            onTap: () {
              Navigator.pushNamed(context, screen);
            }),
      ],
    );
  }
}
