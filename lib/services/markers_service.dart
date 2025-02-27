import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:travel_guard/app_global.dart';
import 'package:travel_guard/models/custom_geopoint.dart';
import 'package:travel_guard/models/custom_marker.dart';
import 'package:travel_guard/models/marker_history.dart';
import 'package:travel_guard/widgets/scaffold_messenger/custom_scaffold_messenger.dart';

class MarkersService {
  static Future<void> addMarker({required CustomGeopoint point, required double radius}) async {
    BuildContext? context = AppGlobal.navigatorKey.currentState?.context;

    if (context == null || !context.mounted) {
      debugPrint("Context is not valid. Skipping marker addition.");
      return;
    }

    try {
      FirebaseFirestore db = FirebaseFirestore.instance;
      FirebaseAuth auth = FirebaseAuth.instance;

      if (auth.currentUser != null) {
        DocumentReference ref = db.collection("users").doc(auth.currentUser!.uid);
        DocumentSnapshot snapshot = await ref.get();

        List<dynamic> markers = (snapshot.data() as Map<String, dynamic>?)?['markers'] ?? [];

        debugPrint("Markers length: ${markers.length}");

        final startingPosition = await Geolocator.getCurrentPosition();

        markers.add(CustomMarker(
          centarPoint: point,
          radius: radius,
          startingPosition: CustomGeopoint(
            latitude: startingPosition.latitude,
            longitude: startingPosition.longitude,
          ),
        ).toJson());

        await db.collection("users").doc(auth.currentUser!.uid).update({
          'markers': markers,
        });

        Future.delayed(Duration.zero, () {
          if (context.mounted) {
            CustomScaffoldMessenger.show(
              context,
              'Marker successfully added!',
              const Color.fromARGB(255, 1, 39, 6),
            );
          }
        });
      }
    } catch (e) {
      debugPrint("Error adding marker: $e");
      if (context.mounted) {
        CustomScaffoldMessenger.show(
          context,
          'Error while adding marker!',
          const Color.fromARGB(255, 47, 1, 1),
        );
      }
    }
  }

  static Future<List<CustomMarker>> getMarkers() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    FirebaseAuth auth = FirebaseAuth.instance;

    if (auth.currentUser == null) {
      debugPrint("No authenticated user, returning empty markers.");
      return [];
    }

    try {
      DocumentReference ref = db.collection("users").doc(auth.currentUser!.uid);
      DocumentSnapshot snapshot = await ref.get();

      if (!snapshot.exists || !snapshot.data().toString().contains('markers')) {
        debugPrint("No markers found in Firestore.");
        return [];
      }

      List<dynamic> rawMarkers = (snapshot.data() as Map<String, dynamic>?)?['markers'] ?? [];

      debugPrint("Raw markers length: ${rawMarkers.length}");

      return rawMarkers.map((marker) => CustomMarker.fromMap(marker as Map<String, dynamic>)).toList();
    } catch (e) {
      debugPrint("Error fetching markers: $e");
      return [];
    }
  }

  static Future<void> removeMarker(CustomGeopoint customMarker) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    FirebaseAuth auth = FirebaseAuth.instance;

    if (auth.currentUser != null) {
      try {
        DocumentSnapshot doc = await db.collection("users").doc(auth.currentUser!.uid).get();

        if (doc.exists) {
          List<dynamic> markers = doc['markers'];

          markers.removeWhere((marker) {
            final lat = (marker['centarPoint']['latitude'] as num).toDouble();
            final long = (marker['centarPoint']['longitude'] as num).toDouble();
            return lat == customMarker.latitude && long == customMarker.longitude;
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
            marker.centarPoint.latitude,
            marker.centarPoint.longitude,
          ) >=
          (distance + marker.radius);
    });
  }

  static Future<void> addMarkerHistory(MarkerHistory historyMarker) async {
    BuildContext? context = AppGlobal.navigatorKey.currentState?.context;

    if (context == null || !context.mounted) {
      debugPrint("Context is not valid. Skipping history addition.");
      return;
    }

    FirebaseFirestore db = FirebaseFirestore.instance;
    FirebaseAuth auth = FirebaseAuth.instance;

    if (auth.currentUser == null) {
      debugPrint("No authenticated user, skipping marker history save.");
      return;
    }

    try {
      DocumentSnapshot doc = await db.collection("users").doc(auth.currentUser!.uid).get();
      List<dynamic> history = (doc.exists && doc.data() != null && (doc.data() as Map<String, dynamic>).containsKey('history')) ? List.from(doc['history']) : [];

      history.add(historyMarker.toJson());

      await db.collection("users").doc(auth.currentUser!.uid).update({
        'history': history,
      });

      Future.delayed(Duration.zero, () {
        if (context.mounted) {
          CustomScaffoldMessenger.show(
            context,
            'Marker successfully added to history!',
            const Color.fromARGB(255, 1, 39, 6),
          );
        }
      });
    } catch (e) {
      debugPrint("Error adding marker history: $e");

      Future.delayed(Duration.zero, () {
        if (context.mounted) {
          CustomScaffoldMessenger.show(
            context,
            'Error while adding marker to history!',
            const Color.fromARGB(255, 40, 6, 6),
          );
        }
      });
    }
  }
}
