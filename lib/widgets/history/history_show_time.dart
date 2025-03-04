import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ShowTimeWidget extends StatelessWidget {
  const ShowTimeWidget({
    super.key,
    required this.historyItem,
    required this.user,
  });

  final dynamic historyItem;
  final User? user;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        Text(
            "${DateTime.parse(historyItem['finished']).day}/${DateTime.parse(historyItem['finished']).month}/${DateTime.parse(historyItem['finished']).year}",
            style: TextStyle(color: Colors.white)),
        InkWell(
          onTap: () {
            FirebaseFirestore.instance
                .collection('users')
                .doc(user!.uid)
                .update({
              'history': FieldValue.arrayRemove([historyItem])
            });
          },
          child: Icon(
            Icons.delete_forever_outlined,
            color: Colors.white,
          ),
        )
      ],
    );
  }
}
