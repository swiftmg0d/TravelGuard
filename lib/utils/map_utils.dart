import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:geolocator/geolocator.dart';
import 'package:travel_guard/services/markers_service.dart';
import 'package:travel_guard/services/notifications_service.dart';
import 'package:travel_guard/providers/map_provider.dart';

class MapUtils {
  static void checkRadiusUpdate(
      Position position, MapState mapState, MapController controller) async {
    final markers = await MarkersService.getMarkers();
    if (markers.isEmpty) {
      return;
    }
    final name = FirebaseAuth.instance.currentUser!.email?.split('@')[0];
    final title =
        "Hi ${name![0].toUpperCase() + name.substring(1)}, You're Near a Point of Interest!";
    final body = "You've entered the marked area. Check it out!";

    for (var marker in markers) {
      if (Geolocator.distanceBetween(position.latitude, position.longitude,
              marker.centarPoint.latitude, marker.centarPoint.longitude) <=
          marker.radius) {
        mapState.setInRadius(true);
        mapState.setCustomMarker(marker);
        debugPrint("In radius: ${position.latitude}, ${position.longitude}");
        debugPrint("${marker.toJson()}");
        break;
      } else {
        mapState.setInRadius(false);
        mapState.setCustomMarker(null);
      }
    }

    if (mapState.inRadius && mapState.customMarker != null) {
      NotificationsService().showNotification(
        title: title,
        body: body,
      );
    }
  }

  static void loadMarkers(MapController controller) async {
    final markers = await MarkersService.getMarkers();
    if (markers.isEmpty) {
      return;
    }

    for (var marker in markers) {
      controller.addMarker(
        marker.centarPoint.toGeoPoint(),
        markerIcon: MarkerIcon(
          icon: Icon(
            Icons.location_on_outlined,
            color: const Color.fromARGB(255, 71, 18, 14),
            size: 30,
          ),
        ),
        angle: 0,
      );
      controller.drawCircle(CircleOSM(
        key: marker.centarPoint.toGeoPoint().toString(),
        centerPoint: marker.centarPoint.toGeoPoint(),
        radius: marker.radius,
        color: Colors.transparent,
        borderColor: Color.fromARGB(255, 184, 46, 36),
        strokeWidth: 2,
      ));
    }
  }
}
