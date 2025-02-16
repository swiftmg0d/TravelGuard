import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travel_guard/dialogs/auth_loading_dialog.dart';
import 'package:travel_guard/screens/home_screen.dart';
import 'package:travel_guard/screens/login_screen.dart';
import 'package:travel_guard/utils/transitions/slide_out.dart';
import 'package:travel_guard/widgets/scaffold_messenger/custom_scaffold_messenger.dart';

class AuthServices {
  static void login(BuildContext context, String email, String password) async {
    showDialog(context: context, builder: (context) => AuthLoading(message: 'Logging in...'));

    if (email.isNotEmpty && password.isNotEmpty) {
      try {
        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
        Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen()));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          Navigator.of(context).pop();
          CustomScaffoldMessenger.show(context, "No user found for that email", const Color.fromARGB(255, 47, 1, 1));
        } else if (e.code == 'wrong-password') {
          Navigator.of(context).pop();
          CustomScaffoldMessenger.show(context, "Wrong password provided for that user", const Color.fromARGB(255, 47, 1, 1));
        } else {
          Navigator.of(context).pop();
          CustomScaffoldMessenger.show(context, "An error occurred. Please try again later", const Color.fromARGB(255, 47, 1, 1));
        }
      }
    } else {
      Navigator.of(context).pop();
      CustomScaffoldMessenger.show(context, "Please fill in all fields", const Color.fromARGB(255, 47, 1, 1));
    }
  }

  static void register(BuildContext context, String email, String password, String confirmPassword) async {
    showDialog(context: context, builder: (context) => AuthLoading(message: 'Creating account...'));
    if (email.isNotEmpty && password.isNotEmpty && confirmPassword.isNotEmpty && confirmPassword == password) {
      try {
        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        Navigator.pop(context);
        if (credential.user != null) {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => LoginScreen(created: true)),
          );
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          Navigator.pop(context);
          CustomScaffoldMessenger.show(context, 'The password provided is too weak', const Color.fromARGB(255, 47, 1, 1));
        } else if (e.code == 'email-already-in-use') {
          Navigator.pop(context);
          CustomScaffoldMessenger.show(context, 'The account already exists for that email', const Color.fromARGB(255, 47, 1, 1));
        } else {
          Navigator.pop(context);
          CustomScaffoldMessenger.show(context, "An error occurred. Please try again", const Color.fromARGB(255, 47, 1, 1));
        }
      }
    } else {
      CustomScaffoldMessenger.show(context, 'Invalid credentials', const Color.fromARGB(255, 47, 1, 1));
      Navigator.pop(context);
    }
  }

  static void logOut(BuildContext context) async {
    showDialog(context: context, builder: (context) => AuthLoading(message: "Logging out..."));
    Future.delayed(Duration(seconds: 3), () {
      FirebaseAuth.instance.signOut();
      Navigator.of(context).push(SlideOut(page: LoginScreen()));
    });
  }
}
