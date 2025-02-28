import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:provider/provider.dart';
import 'package:travel_guard/state/map_state.dart';
import 'package:travel_guard/dialogs/add_marker_dialog.dart';
import 'package:travel_guard/widgets/map/map_loading.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final controller = MapController.withUserPosition(
      trackUserLocation: UserTrackingOption(
    enableTracking: true,
    unFollowUser: false,
  ));
  bool isLoaded = false;
  get isMapReady => isLoaded;
  @override
  void initState() {
    super.initState();
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
                Icons.location_history_rounded,
                color: Colors.red,
                size: 48,
              ),
            ),
            directionArrowMarker: MarkerIcon(
              icon: Icon(
                Icons.double_arrow,
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
