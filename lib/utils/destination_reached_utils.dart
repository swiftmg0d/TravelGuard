import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_guard/app_global.dart';
import 'package:travel_guard/models/custom_marker.dart';
import 'package:travel_guard/models/marker_history.dart';
import 'package:travel_guard/providers/image_provider.dart';
import 'package:travel_guard/providers/map_provider.dart';
import 'package:travel_guard/services/markers_service.dart';

class DestinationReachedUtils {
  static void saveMarker(
      {required String startingAddress,
      required String destinationAddress,
      required DateTime started}) async {
    final currentContext = AppGlobal.navigatorKey.currentState!.context;
    final mapState = Provider.of<MapState>(currentContext, listen: false);
    if (mapState.customMarker != null) {
      final targetMarker = mapState.customMarker!;
      final imagesState =
          Provider.of<ImageState>(currentContext, listen: false);

      final historyMarker = MarkerHistory(
        startingAddress: startingAddress,
        destinationAddress: destinationAddress,
        started: mapState.customMarker!.created,
        finished: DateTime.now(),
        distance: targetMarker.distance(),
        duration: CustomMarker.timeFromTo(targetMarker.created, started),
        startingImage: mapState.customMarker!.startingImage,
        endingImage: imagesState.endingImagePath,
      );
      debugPrint("Saving marker: ${historyMarker.toJson()}");
      await MarkersService.addMarkerHistory(historyMarker);

      if (!currentContext.mounted) return;
      Provider.of<ImageState>(currentContext, listen: false)
          .setStartingImagePath("");
      Provider.of<ImageState>(currentContext, listen: false)
          .setEndingImagePath("");

      MapState.handleDeleting("Saving marker to history...");

      debugPrint("Saving marker: ${historyMarker.toJson()}");
    } else {
      debugPrint('Custom Marker is null');
    }
  }
}
