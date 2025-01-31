import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_guard/utils/transitions/slide_in.dart';

class Button extends StatelessWidget {
  final Widget screen;
  final String text;
  const Button({
    super.key,
    required this.text,
    required this.screen,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 30),
        SizedBox(
          height: 50,
          width: 240,
          child: ElevatedButton(
            onPressed: () => Navigator.of(context).push(SlideIn(page: screen)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 16, 44, 43),
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: Text(
              text,
              style: GoogleFonts.staatliches(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        )
      ],
    );
  }
}
