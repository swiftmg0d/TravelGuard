import 'package:flutter/material.dart';

class EmptyHistoryList extends StatelessWidget {
  const EmptyHistoryList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(bottom: 600),
        width: 320,
        height: 110,
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 14, 35, 32),
            borderRadius: BorderRadius.circular(20)),
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
      ),
    );
  }
}
