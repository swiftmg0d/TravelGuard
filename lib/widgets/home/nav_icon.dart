import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_guard/utils/transitions/slide_out.dart';

class NavIcon extends StatelessWidget {
  final String text;
  final IconData icon;
  final Widget page;
  final bool isActive;
  const NavIcon({required this.text, required this.icon, required this.page, required this.isActive});

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
              Navigator.of(context).push(SlideOut(page: page));
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
