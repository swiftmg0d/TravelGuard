import 'package:flutter/material.dart';
import 'package:travel_guard/widgets/home/bottom_navigation_bar.dart';
import 'package:travel_guard/widgets/home/logo_app_bar.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Material(
        child: Stack(
          children: [
            Container(
                color: Color.fromARGB(255, 244, 251, 250),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 150),
                      Container(
                        width: 320,
                        height: 110,
                        decoration: BoxDecoration(color: Color.fromARGB(255, 22, 59, 57), borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "No history yet",
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            Text(
                              "Your travel history will appear here",
                              style: TextStyle(color: Colors.white, fontSize: 14),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )),
            LogoAppBar(),
            BottomNavBar(active: 0)
          ],
        ),
      ),
    );
  }
}
