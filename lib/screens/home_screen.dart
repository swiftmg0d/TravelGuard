import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_guard/screens/map_screen.dart';
import 'package:travel_guard/state/conectivity_state.dart';
import 'package:travel_guard/state/map_state.dart';
import 'package:travel_guard/widgets/home/logo_app_bar.dart';
import 'package:travel_guard/widgets/home/bottom_navigation_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (Provider.of<ConnectivityProvider>(context, listen: false).getStatus() == false) {
        Navigator.pushNamed(context, '/error', arguments: '/home');
      }
      final mapState = Provider.of<MapState>(context, listen: false);
      if (mapState.isLoaded) {
        Future.delayed(const Duration(microseconds: 100), () {
          mapState.unload();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final mapState = Provider.of<MapState>(context);

    return Scaffold(
        body: Material(
      child: Stack(
        children: [
          MapScreen(),
          if (mapState.isLoaded) ...[
            LogoAppBar(),
            BottomNavBar(
              active: 1,
            ),
          ],
        ],
      ),
    ));
  }
}
