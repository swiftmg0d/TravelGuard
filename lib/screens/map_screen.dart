import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:travel_guard/dialogs/remove_marker_dialog.dart';
import 'package:travel_guard/models/custom_geopoint.dart';
import 'package:travel_guard/services/markers_service.dart';
import 'package:travel_guard/services/notifications_service.dart';
import 'package:travel_guard/state/map_state.dart';
import 'package:travel_guard/dialogs/add_marker_dialog.dart';
import 'package:travel_guard/widgets/map/map_loading.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  bool isLoaded = false;
  get isMapReady => isLoaded;
  Position? currentPosition;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final mapState = Provider.of<MapState>(context, listen: false);
      loadMarkers(mapState.controller);

      Geolocator.getPositionStream(
          locationSettings: LocationSettings(
        accuracy: LocationAccuracy.bestForNavigation,
        distanceFilter: 0,
      )).listen((Position position) {
        if (mapState.sendNotifications) {
          checkRadiusUpdate(position, mapState, mapState.controller);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final mapState = Provider.of<MapState>(context, listen: false);
    return OSMFlutter(
        onMapIsReady: (isReady) {
          if (isReady) {
            mapState.load();
            mapState.controller.listenerMapSingleTapping.addListener(() async {
              if (context.mounted) {
                final parentContext = context;
                Future.delayed(Duration.zero, () {
                  if (parentContext.mounted) {
                    showDialog(
                      context: parentContext,
                      builder: (context) => AddMarkerDialog(
                        value: mapState.controller.listenerMapSingleTapping.value!,
                        controller: mapState.controller,
                      ),
                    );
                  }
                });
              }
            });
          }
        },
        onGeoPointClicked: (geoPoint) async {
          if (context.mounted) {
            final parentContext = context;
            Future.delayed(Duration.zero, () {
              if (parentContext.mounted) {
                showDialog(
                  context: parentContext,
                  builder: (context) => RemoveMarkerDialog(),
                ).then((value) async {
                  if (value) {
                    MapState.handleDeleting("Deleting marker...");
                  }
                });
              }
            });
          }
        },
        mapIsLoading: MapLoading(),
        controller: mapState.controller,
        osmOption: OSMOption(
          userTrackingOption: UserTrackingOption(
            enableTracking: true,
            unFollowUser: false,
          ),
          zoomOption: ZoomOption(
            initZoom: 8,
            minZoomLevel: 3,
            maxZoomLevel: 19,
            stepZoom: 1.0,
          ),
          userLocationMarker: UserLocationMaker(
            personMarker: MarkerIcon(
              icon: Icon(
                Icons.person,
                color: Colors.red,
                size: 48,
              ),
            ),
            directionArrowMarker: MarkerIcon(
              icon: Icon(
                Icons.person,
                color: Colors.red,
                size: 48,
              ),
            ),
          ),
          roadConfiguration: RoadOption(
            roadColor: Colors.yellowAccent,
          ),
        ));
  }
}

void checkRadiusUpdate(Position position, MapState mapState, MapController controller) async {
  final markers = await MarkersService.getMarkers();
  if (markers.isEmpty) {
    return;
  }
  final name = FirebaseAuth.instance.currentUser!.email?.split('@')[0];
  final title = "Hi ${name![0].toUpperCase() + name.substring(1)}, You're Near a Point of Interest!";
  final body = "You've entered the marked area. Check it out!";

  debugPrint("Current position: ${position.latitude}, ${position.longitude}");

  for (var marker in markers) {
    if (Geolocator.distanceBetween(position.latitude, position.longitude, marker.centarPoint.latitude, marker.centarPoint.longitude) <= marker.radius) {
      mapState.setInRadius(true);
      mapState.setCustomMarker(marker);
      debugPrint("${marker.toJson()}");
      break;
    }
  }

  if (mapState.inRadius && mapState.customMarker != null) {
    NotificationsService().showNotification(
      title: title,
      body: body,
    );
  }
}

void loadMarkers(MapController controller) async {
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
      key: marker.centarPoint.toString(),
      centerPoint: marker.centarPoint.toGeoPoint(),
      radius: marker.radius,
      color: Colors.transparent,
      borderColor: Color.fromARGB(255, 184, 46, 36),
      strokeWidth: 2,
    ));
  }
}
