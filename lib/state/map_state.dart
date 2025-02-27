import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart'; // Import for MapController
import 'package:provider/provider.dart';
import 'package:travel_guard/app_global.dart';
import 'package:travel_guard/dialogs/loading_dialog.dart';
import 'package:travel_guard/models/custom_geopoint.dart';
import 'package:travel_guard/models/custom_marker.dart';
import 'package:travel_guard/services/markers_service.dart';

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

  static void resetConfig() {
    BuildContext currentContext = AppGlobal.navigatorKey.currentState!.context;
    final mapState = Provider.of<MapState>(currentContext, listen: false);
    mapState.setInRadius(false);
    mapState.setCustomMarker(null);
    mapState.setSendNotifications(true);
  }

  static Future<void> handleDeleting(String message) async {
    final currentContext = AppGlobal.navigatorKey.currentState?.context;

    if (currentContext == null || !currentContext.mounted) {
      debugPrint("Context is not valid. Skipping delete operation.");
      return;
    }

    final mapState = Provider.of<MapState>(currentContext, listen: false);

    Future.delayed(Duration.zero, () {
      if (currentContext.mounted) {
        showDialog(
          context: currentContext,
          builder: (context) => LoadingDialog(message: message),
        );
      }
    });

    if (mapState.customMarker != null) {
      final geoPoint = mapState.customMarker!.centarPoint;

      await MarkersService.removeMarker(
        CustomGeopoint(latitude: geoPoint.latitude, longitude: geoPoint.longitude),
      );

      await mapState.controller.removeMarker(geoPoint.toGeoPoint());
      await mapState.controller.removeCircle(geoPoint.toGeoPoint().toString());

      MapState.resetConfig();

      if (currentContext.mounted) {
        Navigator.pop(currentContext);
        Navigator.pop(currentContext);
      }
    }
  }
}
