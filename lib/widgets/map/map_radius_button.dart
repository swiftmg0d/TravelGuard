import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MapRadiusBuutton extends StatelessWidget {
  final int distance;
  final bool isSelected;
  final VoidCallback onSelect;

  const MapRadiusBuutton({
    super.key,
    required this.distance,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onSelect,
      child: Text(
        distance.toString(),
        style: GoogleFonts.staatliches(
          color: isSelected
              ? Color.fromARGB(255, 9, 26, 25)
              : Color.fromARGB(220, 14, 37, 36),
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
