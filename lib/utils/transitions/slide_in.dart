import 'package:flutter/material.dart';

class SlideIn extends PageRouteBuilder {
  final Widget page;
  final Curve curve; // Customizable curve

  SlideIn({
    required this.page,
    this.curve = Curves.easeIn,
  }) : super(
          pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) => page,
          transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;

            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);

            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        );
}
