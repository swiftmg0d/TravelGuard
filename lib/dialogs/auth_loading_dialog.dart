import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AuthLoading extends StatefulWidget {
  final String message;
  const AuthLoading({super.key, required this.message});

  @override
  State<AuthLoading> createState() => _AuthLoadingState();
}

class _AuthLoadingState extends State<AuthLoading> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: Colors.transparent,
        content: Container(
          child: Column(
            spacing: 10,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Text(
                  widget.message,
                  style: GoogleFonts.staatliches(
                    color: const Color.fromARGB(255, 25, 67, 64),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                child: Center(
                  child: LoadingAnimationWidget.inkDrop(
                    color: const Color.fromARGB(255, 21, 57, 55),
                    size: 40,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
