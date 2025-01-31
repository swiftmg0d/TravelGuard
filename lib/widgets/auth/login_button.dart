import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:travel_guard/screens/home_screen.dart';
import 'package:travel_guard/state/auth_state.dart';

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
    final authState = Provider.of<AuthState>(context);

    return SizedBox(
      height: 50,
      width: 240,
      child: ElevatedButton(
        onPressed: () {
          final email = emailController.text.trim();
          final password = passwordController.text.trim();
          if (email.isNotEmpty && password.isNotEmpty) {
            authState.login(email, password);

            if (authState.isAuthenticated) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const HomeScreen()),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  width: 200,
                  backgroundColor: const Color.fromARGB(255, 47, 1, 1),
                  content: Text(
                    'Invalid credentials',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.staatliches(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      fontSize: 20,
                      fontWeight: FontWeight.w100,
                    ),
                  ),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                width: 250,
                backgroundColor: const Color.fromARGB(255, 47, 1, 1),
                content: Text(
                  'Please fill in all fields',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.staatliches(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    fontSize: 20,
                    fontWeight: FontWeight.w100,
                  ),
                ),
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
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
