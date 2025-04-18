import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:travel_guard/providers/image_provider.dart';
import 'package:travel_guard/providers/map_provider.dart';

class DestinationReachedDialogDeleteButton extends StatelessWidget {
  const DestinationReachedDialogDeleteButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        final imagesState = Provider.of<ImageState>(context, listen: false);
        imagesState.setEndingImagePath("");
        imagesState.setStartingImagePath("");
        await MapState.handleDeleting("Deleting...");
      },
      child: Container(
        width: 100,
        padding: EdgeInsets.symmetric(vertical: 3, horizontal: 20),
        decoration: BoxDecoration(
          border: Border.all(color: Color.fromARGB(255, 16, 44, 43), width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          "Delete",
          textAlign: TextAlign.center,
          style: GoogleFonts.staatliches(
            color: Color.fromARGB(255, 29, 78, 74),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
