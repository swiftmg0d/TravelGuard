import 'package:flutter/material.dart';
import 'package:travel_guard/widgets/splash/splash_messages.dart';

class SplashAnimatedMessages extends StatelessWidget {
  const SplashAnimatedMessages({
    super.key,
    required int currentIndex,
    required bool isLoaded,
  })  : _currentIndex = currentIndex,
        _isLoaded = isLoaded;

  final int _currentIndex;
  final bool _isLoaded;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 500),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(
          opacity: animation.drive(CurveTween(curve: Curves.easeOut)),
          child: child,
        );
      },
      child: SplashMessages(
          key: ValueKey<int>(_currentIndex),
          currentIndex: _currentIndex,
          isLoaded: _isLoaded),
    );
  }
}
