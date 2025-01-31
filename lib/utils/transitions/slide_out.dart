import 'package:flutter/material.dart';

class SlideOut extends PageRouteBuilder {
  final Widget page;

  SlideOut({
    required this.page,
  }) : super(
          pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) => page,
          transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const reverseBegin = Offset.zero;
            const reverseEnd = Offset(-1.0, 0.0);
            const curve = Curves.easeInOut;

            var forwardTween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var reverseTween = Tween(begin: reverseBegin, end: reverseEnd).chain(CurveTween(curve: curve));

            return Stack(
              children: [
                SlideTransition(
                  position: secondaryAnimation.drive(reverseTween),
                  child: child,
                ),
                SlideTransition(
                  position: animation.drive(forwardTween),
                  child: page,
                ),
              ],
            );
          },
        );
}
