import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travel_guard/models/circle_info.dart';
import 'package:travel_guard/models/custom_marker.dart';
import 'package:travel_guard/models/marker_info.dart';
import 'package:travel_guard/widgets/scaffold_messenger/custom_scaffold_messenger.dart';

class MarkersServices {
  static Future<void> addMarker(CircleInfo circleInfo, MarkerInfo markerInfo, BuildContext context) async {
    try {
      FirebaseFirestore db = FirebaseFirestore.instance;
      FirebaseAuth auth = FirebaseAuth.instance;
      if (auth.currentUser != null) {
        DocumentReference ref = db.collection("users").doc(auth.currentUser!.uid);
        DocumentSnapshot snapshot = await ref.get();

        List<dynamic> markers = (snapshot.data() as Map<String, dynamic>)['markers'] ?? [];
        debugPrint("Markers lenght: ${markers.length}");
        markers.add(CustomMarker(
          circleInfo: circleInfo,
          markerInfo: markerInfo,
          finished: null,
        ).toJson());

        await db.collection("users").doc(auth.currentUser!.uid).update({
          'markers': markers,
        });
        CustomScaffoldMessenger.show(
          context,
          'Marker successfully added!',
          const Color.fromARGB(255, 1, 39, 6),
        );
      }
    } catch (e) {
      print("Error adding marker: $e");
      CustomScaffoldMessenger.show(
        context,
        'Error while adding marker!',
        const Color.fromARGB(255, 47, 1, 1),
      );
    }
  }

  static Future<List<CustomMarker>> getMarkers() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    FirebaseAuth auth = FirebaseAuth.instance;

    if (auth.currentUser == null) {
      print("No authenticated user, returning empty markers.");
      return [];
    }

    try {
      DocumentReference ref = db.collection("users").doc(auth.currentUser!.uid);
      DocumentSnapshot snapshot = await ref.get();

      if (!snapshot.exists || !snapshot.data().toString().contains('markers')) {
        print("No markers found in Firestore.");
        return [];
      }

      List<dynamic> rawMarkers = (snapshot.data() as Map<String, dynamic>)['markers'] ?? [];

      List<CustomMarker> markers = rawMarkers.map((marker) => CustomMarker.fromMap(marker as Map<String, dynamic>)).toList();
      print("Raw markers data: ${markers[0].markerInfo.point}");

      return markers;
    } catch (e) {
      print("Error fetching markers: $e");
      return [];
    }
  }
}
