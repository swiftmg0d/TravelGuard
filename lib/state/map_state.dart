import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart'; // Import for MapController
import 'package:travel_guard/models/custom_marker.dart';

class MapState extends ChangeNotifier {
  bool isLoaded = false;
  bool inRadius = false;
  bool sendNotifications = true;
  CustomMarker? customMarker;
  MapController controller = MapController.withUserPosition(
      trackUserLocation: UserTrackingOption(
    enableTracking: true,
    unFollowUser: false,
  ));

  void load() {
    isLoaded = true;
    notifyListeners();
  }

  void unload() {
    isLoaded = false;
    notifyListeners();
  }

  void setInRadius(bool value) {
    inRadius = value;
    notifyListeners();
  }

  void setSendNotifications(bool value) {
    sendNotifications = value;
    notifyListeners();
  }

  void setCustomMarker(CustomMarker? value) {
    customMarker = value;
    notifyListeners();
  }
}
