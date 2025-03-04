import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:travel_guard/providers/conectivity_provider.dart';
import 'package:travel_guard/widgets/scaffold_messenger/custom_scaffold_messenger.dart';

class ErrorScreen extends StatefulWidget {
  final String screen;
  const ErrorScreen({
    super.key,
    required this.screen,
  });

  @override
  State<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Stack(children: [
          Center(
            child: AnimatedContainer(
              width: 350,
              margin: EdgeInsets.only(bottom: 700),
              duration: Duration(seconds: 2),
              child: Text(
                "You are not connected to the internet",
                style: GoogleFonts.staatliches(
                    color: const Color.fromARGB(255, 40, 6, 6),
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Center(
            child: Container(
              child: Lottie.asset("assets/icons_json/lost_conection.json",
                  fit: BoxFit.cover, width: 350, height: 350),
            ),
          ),
          Center(
            child: Container(
              width: 250,
              margin: EdgeInsets.only(top: 550),
              child: Center(
                child: TextButton(
                    onPressed: () {
                      final status =
                          Provider.of<ConnectivityState>(context, listen: false)
                              .getStatus();
                      if (status == true) {
                        Navigator.pushReplacementNamed(context, widget.screen);
                      } else {
                        CustomScaffoldMessenger.show(
                            context,
                            "No network connection",
                            Color.fromARGB(255, 40, 6, 6));
                      }
                    },
                    child: Text("Try again",
                        style: GoogleFonts.staatliches(
                            color: const Color.fromARGB(255, 40, 6, 6),
                            fontSize: 25,
                            fontWeight: FontWeight.bold))),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
