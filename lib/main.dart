import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_guard/screens/home_screen.dart';
import 'package:travel_guard/state/auth_state.dart';
import 'package:travel_guard/state/map_state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthState()),
        ChangeNotifierProvider(create: (_) => MapState())
      ],
      child: MaterialApp(
        title: 'TravelGuard',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
