import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:travel_guard/providers/conectivity_provider.dart';
import 'package:travel_guard/widgets/auth/auth_custum_app_bar.dart';
import 'package:travel_guard/widgets/auth/auth_info_account.dart';
import 'package:travel_guard/widgets/auth/auth_input.dart';
import 'package:travel_guard/widgets/auth/auth_register_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (Provider.of<ConnectivityState>(context, listen: false).getStatus() ==
          false) {
        Navigator.pushNamed(context, '/error', arguments: '/register');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Container(
            color: const Color.fromARGB(255, 244, 251, 250),
            child: Opacity(
              opacity: 0.1,
              child: Center(
                child: Image.asset(
                  "assets/icons/logo.png",
                  fit: BoxFit.contain,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            padding: EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                AuthCustomAppBar(screen: '/login'),
                const SizedBox(height: 80),
                Text(
                  "Create an account",
                  style: GoogleFonts.staatliches(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 90),
                AuthInput(
                  label: "Email",
                  hint: "tg@example.com",
                  controler: _emailController,
                  obscureText: false,
                ),
                const SizedBox(height: 20),
                AuthInput(
                  label: "Password",
                  hint: "strongpassword",
                  controler: _passwordController,
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                AuthInput(
                  label: "Confirm Password",
                  hint: "strongpassword",
                  controler: _confirmPasswordController,
                  obscureText: true,
                ),
                const SizedBox(height: 40),
                AuthRegisterButton(
                  emailController: _emailController,
                  passwordController: _passwordController,
                  confirmPasswordController: _confirmPasswordController,
                ),
                const SizedBox(height: 20),
                AuthInfoAccount(
                  title: "Already have an account? ",
                  subtitle: "Sign in",
                  screen: '/login',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
