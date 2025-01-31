import 'package:flutter/material.dart';

class LogoAppBar extends StatelessWidget {
  const LogoAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              child: Image.asset(
                'assets/icons/logo.png',
                width: 150,
                height: 150,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: 11,
                  right: 13,
                ),
                child: Container(height: 5, decoration: BoxDecoration(border: Border.all(color: Color.fromARGB(255, 16, 44, 43), width: 2), borderRadius: BorderRadius.circular(10), color: Color.fromARGB(255, 16, 44, 43)), child: Text("")),
              ),
            )
          ],
        )
      ],
    );
  }
}
