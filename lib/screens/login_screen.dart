import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:travel_guard/providers/conectivity_provider.dart';
import 'package:travel_guard/widgets/auth/auth_custum_app_bar.dart';
import 'package:travel_guard/widgets/auth/auth_info_account.dart';
import 'package:travel_guard/widgets/auth/auth_input.dart';
import 'package:travel_guard/widgets/auth/auth_login_button.dart';
import 'package:travel_guard/widgets/scaffold_messenger/custom_scaffold_messenger.dart';

class LoginScreen extends StatefulWidget {
  final bool? created;
  const LoginScreen({super.key, this.created});

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
      if (Provider.of<ConnectivityState>(context, listen: false).getStatus() ==
          false) {
        Navigator.pushNamed(context, '/error', arguments: '/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return LoginWidget(
      emailController: _emailController,
      passwordController: _passwordController,
    );
  }
}

class LoginWidget extends StatelessWidget {
  const LoginWidget({
    super.key,
    required TextEditingController emailController,
    required TextEditingController passwordController,
  })  : _emailController = emailController,
        _passwordController = passwordController;

  final TextEditingController _emailController;
  final TextEditingController _passwordController;

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
                child: Image.asset("assets/icons/logo.png",
                    fit: BoxFit.contain,
                    width: MediaQuery.of(context).size.width),
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
                AuthCustomAppBar(screen: '/splash'),
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
                const SizedBox(height: 70),
                AuthLoginButton(
                  emailController: _emailController,
                  passwordController: _passwordController,
                ),
                const SizedBox(height: 20),
                AuthInfoAccount(
                  title: "Don't have an account? ",
                  subtitle: "Sign up",
                  screen: '/register',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
