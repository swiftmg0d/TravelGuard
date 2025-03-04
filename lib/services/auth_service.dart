import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travel_guard/dialogs/loading_dialog.dart';
import 'package:travel_guard/models/custom_user.dart';
import 'package:travel_guard/widgets/scaffold_messenger/custom_scaffold_messenger.dart';

class AuthService {
  static void login(BuildContext context, String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      CustomScaffoldMessenger.show(context, "Please fill in all fields",
          const Color.fromARGB(255, 47, 1, 1));
      return;
    }

    showDialog(
        context: context,
        builder: (context) => LoadingDialog(message: 'Logging in...'));

    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (!context.mounted) return;
      Navigator.pushNamedAndRemoveUntil(
          context, '/home', (Route<dynamic> route) => false);
    } on FirebaseAuthException catch (e) {
      if (!context.mounted) return;

      Navigator.of(context).pop();
      if (e.code == 'user-not-found') {
        CustomScaffoldMessenger.show(context, "No user found for that email",
            const Color.fromARGB(255, 47, 1, 1));
      } else if (e.code == 'wrong-password') {
        CustomScaffoldMessenger.show(
            context,
            "Wrong password provided for that user",
            const Color.fromARGB(255, 47, 1, 1));
      } else if (e.code == 'error-invalid-credential') {
        CustomScaffoldMessenger.show(context, "Invalid credentials",
            const Color.fromARGB(255, 47, 1, 1));
      } else {
        CustomScaffoldMessenger.show(
            context,
            "An error occurred. Please try again",
            const Color.fromARGB(255, 47, 1, 1));
      }
    }
  }

  static void register(BuildContext context, String email, String password,
      String confirmPassword) async {
    if (email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty ||
        password != confirmPassword) {
      CustomScaffoldMessenger.show(
        context,
        "Please fill in all fields or passwords do not match",
        const Color.fromARGB(255, 47, 1, 1),
      );
      return;
    }

    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) =>
            const LoadingDialog(message: 'Creating account...'),
      );
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user != null) {
        CustomUser currentUser = CustomUser(
          id: credential.user!.uid,
          email: email,
          password: sha256.convert(utf8.encode(password)).toString(),
        );

        await FirebaseFirestore.instance
            .collection('users')
            .doc(credential.user!.uid)
            .set(currentUser.toJson());

        await FirebaseAuth.instance.signOut();
        if (!context.mounted) return;
        Navigator.pop(context);

        Navigator.pushNamedAndRemoveUntil(
          context,
          '/login',
          (Route<dynamic> route) => false,
          arguments: true,
        );

        return;
      }
    } on FirebaseAuthException catch (e) {
      if (!context.mounted) return;
      Navigator.pop(context);
      if (e.code == 'weak-password') {
        CustomScaffoldMessenger.show(
          context,
          'The password provided is too weak',
          const Color.fromARGB(255, 47, 1, 1),
        );
      } else if (e.code == 'email-already-in-use') {
        CustomScaffoldMessenger.show(
          context,
          'The account already exists for that email',
          const Color.fromARGB(255, 47, 1, 1),
        );
      } else {
        CustomScaffoldMessenger.show(
          context,
          "An error occurred. Please try again",
          const Color.fromARGB(255, 47, 1, 1),
        );
      }
    }
  }

  static Future<void> logOut(BuildContext context) async {
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const LoadingDialog(message: "Logging out..."),
      );

      await FirebaseAuth.instance.signOut();

      Future.delayed(Duration(seconds: 2), () {
        if (!context.mounted) return;

        Navigator.of(context).pop();

        Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
      });
    } catch (e) {
      debugPrint("Error logging out: $e");
      if (!context.mounted) return;

      Navigator.of(context).pop();

      CustomScaffoldMessenger.show(
        context,
        "An error occurred. Please try again",
        const Color.fromARGB(255, 47, 1, 1),
      );
    }
  }
}
