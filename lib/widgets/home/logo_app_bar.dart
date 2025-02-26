import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LogoAppBar extends StatefulWidget {
  final List<String> messages = [
    "Explore the world with Travel Guard",
    "Travel Guard is here to help you",
    "It's your best travel companion",
    "Click on the map to add a marker",
    "Your travel is safe with Travel Guard",
  ];
  LogoAppBar({
    super.key,
  });

  @override
  State<LogoAppBar> createState() => _LogoAppBarState();
}

class _LogoAppBarState extends State<LogoAppBar> {
  late Timer _timer;
  String message = "Hi there, Welcome to Travel Guard";

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(children: [
          Container(
            margin: EdgeInsets.only(top: 45, left: 153),
            child: Text(
              message,
              style: GoogleFonts.staatliches(fontSize: 16, color: Color.fromARGB(255, 19, 50, 49)),
              softWrap: true,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                child: Image.asset(
                  'assets/icons/logo.png',
                  width: 150,
                  height: 150,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    bottom: 11,
                    right: 13,
                  ),
                  child: Container(height: 5, decoration: BoxDecoration(border: Border.all(color: Color.fromARGB(255, 16, 44, 43), width: 2), borderRadius: BorderRadius.circular(10), color: Color.fromARGB(255, 16, 44, 43)), child: Text("")),
                ),
              )
            ],
          )
        ])
      ],
    );
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 15), (timer) {
      setState(() {
        message = widget.messages[Random().nextInt(widget.messages.length)];
      });
    });
  }
}
