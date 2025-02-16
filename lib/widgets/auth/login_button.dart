import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_guard/services/auth_services.dart';

class LoginButton extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginButton({
    required this.emailController,
    required this.passwordController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 240,
      child: ElevatedButton(
        onPressed: () {
          AuthServices.login(context, emailController.text.trim(), passwordController.text.trim());
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 16, 44, 43),
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Text(
          "Login",
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
