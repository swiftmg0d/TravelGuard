import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:travel_guard/utils/constants/messsages.dart';
import 'package:travel_guard/widgets/splash/animated_messages.dart';
import 'package:travel_guard/widgets/splash/button.dart';
import 'package:travel_guard/widgets/splash/loading.dart';
import 'package:travel_guard/widgets/splash/logo.dart';
import 'package:travel_guard/widgets/splash/version.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;
  int _currentIndex = 0;
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(milliseconds: 2500), (timer) {
      setState(() {
        if (timer.tick == 5) {
          _isLoaded = true;
          _timer.cancel();
        }
        _currentIndex = Random().nextInt(LoadingMessages.messages.length);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SplashWidget(isLoaded: _isLoaded, currentIndex: _currentIndex));
  }
}

class SplashWidget extends StatelessWidget {
  const SplashWidget({
    super.key,
    required bool isLoaded,
    required int currentIndex,
  })  : _isLoaded = isLoaded,
        _currentIndex = currentIndex;

  final bool _isLoaded;
  final int _currentIndex;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        color: Color.fromARGB(255, 244, 251, 250),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 150),
            Logo(width: 320, height: 270),
            _isLoaded ? Button(screen: '/login', text: "Start the journey") : Loading(),
            SizedBox(height: 40),
            AnimatedMessages(currentIndex: _currentIndex, isLoaded: _isLoaded),
            SizedBox(height: 135),
            Version()
          ],
        ),
      ),
    );
  }
}
