import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HistoryDetailsTitle extends StatelessWidget {
  const HistoryDetailsTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Center(
        child: Text(
          'History Details',
          style: GoogleFonts.staatliches(
              fontSize: 25, color: Color.fromARGB(255, 19, 50, 49)),
        ),
      ),
    );
  }
}
