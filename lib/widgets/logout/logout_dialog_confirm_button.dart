import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_guard/services/auth_services.dart';

class LogOutDialogConfirmButton extends StatelessWidget {
  const LogOutDialogConfirmButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        AuthServices.logOut(context);
      },
      child: Container(
        padding: EdgeInsets.only(top: 3, bottom: 3, left: 20, right: 20),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 18, 68, 64),
          border: Border.all(color: Color.fromARGB(255, 16, 44, 43), width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text("Logout",
            style: GoogleFonts.staatliches(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )),
      ),
    );
  }
}
