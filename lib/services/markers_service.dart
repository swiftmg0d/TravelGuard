import 'dart:nativewrappers/_internal/vm/lib/math_patch.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:travel_guard/models/circle_info.dart';
import 'package:travel_guard/models/custom_geopoint.dart';
import 'package:travel_guard/models/custom_marker.dart';
import 'package:travel_guard/models/marker_info.dart';
import 'package:travel_guard/widgets/scaffold_messenger/custom_scaffold_messenger.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class MarkersService {
  static Future<void> addMarker(CircleInfo circleInfo, MarkerInfo markerInfo, BuildContext context) async {
    try {
      FirebaseFirestore db = FirebaseFirestore.instance;
      FirebaseAuth auth = FirebaseAuth.instance;
      if (auth.currentUser != null) {
        DocumentReference ref = db.collection("users").doc(auth.currentUser!.uid);
        DocumentSnapshot snapshot = await ref.get();

        List<dynamic> markers = (snapshot.data() as Map<String, dynamic>)['markers'] ?? [];
        debugPrint("Markers lenght: ${markers.length}");
        final startingPosition = await Geolocator.getCurrentPosition();
// Add the marker (after converting the GeoPoint)
        markers.add(CustomMarker(
          circleInfo: circleInfo,
          markerInfo: markerInfo,
          finished: null,
          startingPosition: CustomGeopoint(
            latitude: startingPosition.latitude,
            longitude: startingPosition.longitude,
          ),
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
      print("Raw markers length: ${markers.length}");

      return markers;
    } catch (e) {
      print("Error fetching markers: $e");
      return [];
    }
  }

  static Future<void> removeMarker(CustomMarker customMarker) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    FirebaseAuth auth = FirebaseAuth.instance;

    if (auth.currentUser != null) {
      try {
        DocumentSnapshot doc = await db.collection("users").doc(auth.currentUser!.uid).get();

        if (doc.exists) {
          List<dynamic> markers = doc['markers'];

          markers.removeWhere((marker) {
            final lat = (marker['markerInfo']['point']['latitude'] as num).toDouble();
            final long = (marker['markerInfo']['point']['longitude'] as num).toDouble();
            return lat == customMarker.markerInfo.point.latitude && long == customMarker.markerInfo.point.longitude;
          });

          await db.collection("users").doc(auth.currentUser!.uid).update({
            'markers': markers,
          });
          debugPrint("Successfully removed marker: ${customMarker.toJson()}");
        } else {
          debugPrint("User document not found.");
        }
      } on FirebaseException catch (e) {
        debugPrint("Firebase error removing marker: ${e.message}");
      } catch (e) {
        debugPrint("Error removing marker: $e");
      }
    }
  }

  static Future<bool> checkIfDistanceIsValid(CustomGeopoint value, int distance) async {
    final markers = await getMarkers();
    return markers.every((marker) {
      return Geolocator.distanceBetween(
            value.latitude,
            value.longitude,
            marker.markerInfo.point.latitude,
            marker.markerInfo.point.longitude,
          ) >=
          (distance + marker.circleInfo.radius);
    });
  }
}
