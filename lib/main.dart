import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:travel_guard/app_global.dart';
import 'package:travel_guard/screens/error_screen.dart';
import 'package:travel_guard/screens/history_screen.dart';
import 'package:travel_guard/screens/home_screen.dart';
import 'package:travel_guard/screens/login_screen.dart';
import 'package:travel_guard/screens/register_screen.dart';
import 'package:travel_guard/screens/splash_screen.dart';
import 'package:travel_guard/services/notifications_service.dart';
import 'package:travel_guard/state/map_state.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/cupertino.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Geolocator.requestPermission();
  await NotificationsService().init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MapState())
      ],
      child: MainWidget(),
    );
  }
}

class MainWidget extends StatelessWidget {
  const MainWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TravelGuard',
      navigatorKey: AppGlobal.navigatorKey,
      scaffoldMessengerKey: scaffoldMessengerKey,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 255, 255, 255)),
        useMaterial3: true,
      ),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        return routeLogic(settings);
      },
    );
  }
}

Route<dynamic>? routeLogic(RouteSettings settings) {
  final currentUser = FirebaseAuth.instance.currentUser;
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (context) => currentUser != null ? const HomeScreen() : const SplashScreen());
    case '/home':
      return MaterialPageRoute(builder: (context) => const HomeScreen());
    case '/login':
      return CupertinoPageRoute(builder: (context) => settings.arguments != null ? LoginScreen(created: settings.arguments as bool) : LoginScreen());
    case '/register':
      return CupertinoPageRoute(builder: (context) => const RegisterScreen());
    case '/history':
      return MaterialPageRoute(builder: (context) => const HistoryScreen());
    case '/error':
      return MaterialPageRoute(builder: (context) => const ErrorScreen());
    case '/splash':
      return CupertinoPageRoute(builder: (context) => const SplashScreen());
    default:
      return null;
  }
}
