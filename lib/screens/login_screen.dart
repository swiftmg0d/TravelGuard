import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_guard/screens/register_screen.dart';
import 'package:travel_guard/screens/splash_screen.dart';
import 'package:travel_guard/widgets/auth/custum_app_bar.dart';
import 'package:travel_guard/widgets/auth/info_account.dart';
import 'package:travel_guard/widgets/auth/input.dart';
import 'package:travel_guard/widgets/auth/login_button.dart';
import 'package:travel_guard/widgets/scaffold_messenger/custom_scaffold_messenger.dart';

class LoginScreen extends StatefulWidget {
  bool? created;
  LoginScreen({super.key, this.created});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.created != null && widget.created!) {
        CustomScaffoldMessenger.show(
          context,
          'Account created successfully',
          const Color.fromARGB(255, 1, 39, 6),
        );
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
                child: Image.asset("assets/icons/logo.png", fit: BoxFit.contain, width: MediaQuery.of(context).size.width),
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
                CustomAppBar(screen: SplashScreen()),
                const SizedBox(height: 80),
                Text(
                  "Sign in to your account",
                  style: GoogleFonts.staatliches(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 80),
                Input(
                  label: "Email",
                  hint: "tg@example.com",
                  controler: _emailController,
                  obscureText: false,
                ),
                const SizedBox(height: 20),
                Input(
                  label: "Password",
                  hint: "strongpassword",
                  controler: _passwordController,
                  obscureText: true,
                ),
                const SizedBox(height: 70),
                LoginButton(
                  emailController: _emailController,
                  passwordController: _passwordController,
                ),
                const SizedBox(height: 20),
                InfoAccount(
                  text1: "Don't have an account? ",
                  text2: "Sign up",
                  screen: RegisterScreen(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
