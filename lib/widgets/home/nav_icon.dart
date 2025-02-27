import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NavIcon extends StatelessWidget {
  final String text;
  final IconData icon;
  final String page;
  final bool isActive;
  const NavIcon({super.key, required this.text, required this.icon, required this.page, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Opacity(
          opacity: isActive ? 1.0 : 0.85,
          child: IconButton(
            iconSize: 35,
            icon: Icon(icon),
            color: Color.fromARGB(255, 14, 37, 36),
            onPressed: () {
              isActive ? null : Navigator.pushReplacementNamed(context, page);
            },
          ),
        ),
        Opacity(
          opacity: isActive ? 1.0 : 0.85,
          child: Text(text,
              style: GoogleFonts.staatliches(
                color: Color.fromARGB(255, 14, 37, 36),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
        )
      ],
    );
  }
}
