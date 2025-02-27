import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingDialog extends StatefulWidget {
  final String message;
  const LoadingDialog({super.key, required this.message});

  @override
  State<LoadingDialog> createState() => _LoadingDialogState();
}

class _LoadingDialogState extends State<LoadingDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: Colors.transparent,
        content: Column(
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.message,
              style: GoogleFonts.staatliches(
                color: const Color.fromARGB(255, 25, 67, 64),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Center(
              child: LoadingAnimationWidget.dotsTriangle(
                color: const Color.fromARGB(255, 21, 57, 55),
                size: 40,
              ),
            ),
          ],
        ));
  }
}
