import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_guard/utils/destination_reached_utils.dart';

class DestinationReachedDialogSaveButton extends StatelessWidget {
  final String startingAddress;
  final String destinationAddress;
  final DateTime started;

  const DestinationReachedDialogSaveButton({
    super.key,
    required this.startingAddress,
    required this.destinationAddress,
    required this.started,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        DestinationReachedUtils.saveMarker(
            startingAddress: startingAddress,
            destinationAddress: destinationAddress,
            started: started);
      },
      child: Container(
        width: 100,
        padding: EdgeInsets.symmetric(vertical: 3, horizontal: 20),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 18, 68, 64),
          border: Border.all(color: Color.fromARGB(255, 16, 44, 43), width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          textAlign: TextAlign.center,
          "Save",
          style: GoogleFonts.staatliches(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
