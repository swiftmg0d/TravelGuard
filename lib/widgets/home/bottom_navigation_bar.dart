import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_guard/dialogs/logout_dialog.dart';
import 'package:travel_guard/widgets/home/nav_icon.dart';

class BottomNavBar extends StatelessWidget {
  final int active;
  const BottomNavBar({
    super.key,
    required this.active,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: 1.0,
      duration: const Duration(seconds: 10),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                NavIcon(text: "History", icon: Icons.history, page: '/history', isActive: active == 0),
                NavIcon(text: "Markers", icon: Icons.location_on, page: '/home', isActive: active == 1),
                Column(
                  children: [
                    Opacity(
                      opacity: active == 2 ? 1.0 : 0.85,
                      child: IconButton(
                        iconSize: 35,
                        icon: Icon(Icons.logout),
                        color: Color.fromARGB(255, 14, 37, 36),
                        onPressed: () {
                          showDialog(context: context, builder: (context) => LogoutDialog());
                        },
                      ),
                    ),
                    Opacity(
                      opacity: active == 2 ? 1.0 : 0.85,
                      child: Text("Logout",
                          style: GoogleFonts.staatliches(
                            color: Color.fromARGB(255, 14, 37, 36),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          )),
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
