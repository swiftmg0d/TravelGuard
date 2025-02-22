import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_guard/widgets/splash/button.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          color: const Color.fromARGB(255, 244, 251, 250),
          child: Opacity(
            opacity: 0.1,
            child: Center(
              child: Image.asset("assets/icons/logo.png", fit: BoxFit.contain, width: MediaQuery.of(context).size.width),
            ),
          ),
        ),
        Container(
          width: 250,
          margin: EdgeInsets.only(left: 80, bottom: 450),
          child: Center(
            child: Text(
              textAlign: TextAlign.center,
              "An error occurred. Please try again later",
              style: GoogleFonts.staatliches(
                color: const Color.fromARGB(255, 40, 6, 6),
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Container(
          width: 250,
          margin: EdgeInsets.only(left: 80, top: 550),
          child: Center(
            child: Button(text: "Go back", screen: '/splash'),
          ),
        )
      ]),
    );
  }
}
