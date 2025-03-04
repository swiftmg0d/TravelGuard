import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_guard/providers/conectivity_provider.dart';
import 'package:travel_guard/constants/messsages.dart';
import 'package:travel_guard/widgets/splash/splash_animated_messages.dart';
import 'package:travel_guard/widgets/splash/splash_button.dart';
import 'package:travel_guard/widgets/splash/splash_loading.dart';
import 'package:travel_guard/widgets/splash/splash_logo.dart';
import 'package:travel_guard/widgets/splash/splash_version.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (Provider.of<ConnectivityState>(context, listen: false).getStatus() ==
          false) {
        Navigator.pushNamed(context, '/error', arguments: '/splash');
      }
    });
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
    return Scaffold(
        body: SplashWidget(isLoaded: _isLoaded, currentIndex: _currentIndex));
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
            SplashLogo(width: 320, height: 270),
            SizedBox(height: 50),
            _isLoaded
                ? SplashButton(screen: '/login', text: "Start the journey")
                : SplashLoading(),
            SizedBox(height: 40),
            SplashAnimatedMessages(
                currentIndex: _currentIndex, isLoaded: _isLoaded),
            SizedBox(height: 135),
            SplashVersion()
          ],
        ),
      ),
    );
  }
}
