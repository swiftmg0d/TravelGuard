import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';

class MapLoading extends StatelessWidget {
  const MapLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PopScope(
        canPop: false,
        child: Material(
            color: Color.fromARGB(255, 244, 251, 250),
            child: Stack(
              children: [
                BackgroundLogo(),
                Center(
                  child: LoadingAnimationWidget.inkDrop(
                    color: Color.fromARGB(255, 21, 57, 55),
                    size: 40,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 100),
                    Center(
                      child: Text(
                        "Loading the map...",
                        style: GoogleFonts.staatliches(
                          color: Color.fromARGB(255, 29, 78, 74),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Transform(
                  transform: Matrix4.translationValues(205, 700, 1),
                  child: Container(
                    child: Lottie.asset('assets/icons_json/a3.json', width: 600, height: 300, fit: BoxFit.contain, alignment: Alignment.topRight),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

class BackgroundLogo extends StatelessWidget {
  const BackgroundLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 244, 251, 250),
      child: Opacity(
        opacity: 0.1,
        child: Center(
          child: Image.asset("assets/icons/logo.png", fit: BoxFit.contain, width: MediaQuery.of(context).size.width),
        ),
      ),
    );
  }
}
