import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:travel_guard/dialogs/loading_dialog.dart';
import 'package:travel_guard/dialogs/remove_marker_dialog.dart';
import 'package:travel_guard/models/custom_geopoint.dart';
import 'package:travel_guard/services/markers_service.dart';
import 'package:travel_guard/providers/map_provider.dart';
import 'package:travel_guard/dialogs/add_marker_dialog.dart';
import 'package:travel_guard/utils/map_utils.dart';
import 'package:travel_guard/widgets/map/map_loading.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen>
    with AutomaticKeepAliveClientMixin {
  bool isLoaded = false;
  get isMapReady => isLoaded;
  Position? currentPosition;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final mapState = Provider.of<MapState>(context, listen: false);

      MapUtils.loadMarkers(mapState.controller);

      Geolocator.getPositionStream(
          locationSettings: LocationSettings(
        accuracy: LocationAccuracy.bestForNavigation,
        distanceFilter: 0,
      )).listen((Position position) {
        if (mapState.sendNotifications) {
          MapUtils.checkRadiusUpdate(position, mapState, mapState.controller);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final mapState = Provider.of<MapState>(context, listen: false);

    return OSMFlutter(
        onMapIsReady: (isReady) {
          if (isReady) {
            mapState.load();
            mapState.controller.listenerMapSingleTapping.addListener(() async {
              if (context.mounted) {
                showDialog(
                  context: Navigator.of(context, rootNavigator: true).context,
                  builder: (context) => AddMarkerDialog(
                    value: mapState.controller.listenerMapSingleTapping.value!,
                    controller: mapState.controller,
                  ),
                );
              }
            });
          }
        },
        onGeoPointClicked: (geoPoint) async {
          if (!context.mounted) return;

          bool shouldRemove = await showDialog(
            context: context,
            builder: (context) => RemoveMarkerDialog(),
          );

          if (shouldRemove) {
            if (!context.mounted) return;
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) =>
                  LoadingDialog(message: 'Removing marker...'),
            );

            try {
              await mapState.controller.removeMarker(geoPoint);
              await mapState.controller.removeCircle(geoPoint.toString());

              await MarkersService.removeMarker(CustomGeopoint(
                latitude: geoPoint.latitude,
                longitude: geoPoint.longitude,
              ));

              if (context.mounted) {
                Navigator.of(context).pop();
                mapState.refreshMap();
                MapState.resetConfig();
              }
            } catch (e) {
              debugPrint("Error removing marker: $e");

              if (context.mounted) {
                Navigator.of(context).pop();
              }
            }
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

  @override
  bool get wantKeepAlive => true;
}
