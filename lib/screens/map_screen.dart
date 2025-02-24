import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geolocator_platform_interface/src/models/position.dart';
import 'package:provider/provider.dart';
import 'package:travel_guard/services/auth_service.dart';
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

Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error('Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}

class _MapScreenState extends State<MapScreen> {
  final controller = MapController.withUserPosition(
      trackUserLocation: UserTrackingOption(
    enableTracking: true,
    unFollowUser: false,
  ));

  bool isLoaded = false;
  get isMapReady => isLoaded;
  Position? currentPosition;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final mapState = Provider.of<MapState>(context, listen: false);

      loadMarkers(controller);

      _determinePosition().then((value) {
        setState(() {
          currentPosition = value;
        });

        controller.moveTo(GeoPoint(latitude: currentPosition!.latitude, longitude: currentPosition!.longitude), animate: true);

        Geolocator.getPositionStream(
            locationSettings: LocationSettings(
          accuracy: LocationAccuracy.bestForNavigation,
          distanceFilter: 0,
        )).listen((Position position) {
          checkRadiusUpdate(position, mapState);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final mapState = Provider.of<MapState>(context);
    return OSMFlutter(
        onMapIsReady: (isReady) {
          if (isReady) {
            mapState.load();
            controller.listenerMapSingleTapping.addListener(() async {
              showDialog(context: context, builder: (context) => AddMarkerDialog(value: controller.listenerMapSingleTapping.value!, controller: controller));
            });
          }
        },
        mapIsLoading: MapLoading(),
        controller: controller,
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

void checkRadiusUpdate(Position position, MapState mapState) {
  late final _timer;
  final name = FirebaseAuth.instance.currentUser!.email?.split('@')[0];
  final title = "Hi ${name![0].toUpperCase() + name!.substring(1)}, You're Near a Point of Interest!";
  final body = "You've entered the marked area. Check it out!";

  debugPrint("Current position: ${position.latitude}, ${position.longitude}");
  MarkersService.getMarkers().then((markers) {
    for (var marker in markers) {
      if (Geolocator.distanceBetween(position.latitude, position.longitude, marker.markerInfo.point.latitude, marker.markerInfo.point.longitude) <= marker.circleInfo.radius) {
        if (!mapState.inRadius) {
          mapState.setInRadius(false);
          _timer = Timer.periodic(Duration(seconds: 5), (timer) {
            if (mapState.sendNotifications) {
              timer.cancel();
            }
            NotificationsService().showNotification(
              title: title,
              body: body,
            );
          });
        }
      }
    }
  });
}

void loadMarkers(MapController controller) {
  MarkersService.getMarkers().then((markers) {
    for (var marker in markers) {
      controller.addMarker(
        marker.markerInfo.point,
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
        key: marker.circleInfo.centerPoint.toString(),
        centerPoint: marker.circleInfo.centerPoint,
        radius: marker.circleInfo.radius,
        color: Colors.transparent,
        borderColor: Color.fromARGB(255, 184, 46, 36),
        strokeWidth: marker.circleInfo.strokeWidth,
      ));
    }
  });
}
