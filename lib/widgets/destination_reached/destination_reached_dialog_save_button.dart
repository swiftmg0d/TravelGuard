import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:travel_guard/app_global.dart';
import 'package:travel_guard/models/custom_marker.dart';
import 'package:travel_guard/models/marker_history.dart';
import 'package:travel_guard/services/markers_service.dart';
import 'package:travel_guard/state/images_state.dart';
import 'package:travel_guard/state/map_state.dart';

class DestinationReachedDialogSaveButton extends StatelessWidget {
  final String startingAddress;
  final String destinationAddress;
  final DateTime started;

  const DestinationReachedDialogSaveButton({
    super.key,
    required this.startingAddress,
    required this.destinationAddress,
    required this.started,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        saveMarker();
      },
      child: Container(
        width: 100,
        padding: EdgeInsets.symmetric(vertical: 3, horizontal: 20),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 18, 68, 64),
          border: Border.all(color: Color.fromARGB(255, 16, 44, 43), width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          textAlign: TextAlign.center,
          "Save",
          style: GoogleFonts.staatliches(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void saveMarker() async {
    final currentContext = AppGlobal.navigatorKey.currentState!.context;
    final mapState = Provider.of<MapState>(currentContext, listen: false);
    if (mapState.customMarker != null) {
      final targetMarker = mapState.customMarker!;

      final historyMarker = MarkerHistory(
        startingAddress: startingAddress,
        destinationAddress: destinationAddress,
        started: mapState.customMarker!.created,
        finished: DateTime.now(),
        distance: targetMarker.distance(),
        duration: CustomMarker.timeFromTo(targetMarker.created, started),
        startingImage: mapState.customMarker!.startingImage,
        endingImage: Provider.of<ImagesState>(currentContext, listen: false).endingImagePath,
      );
      debugPrint("Saving marker: ${historyMarker.toJson()}");
      await MarkersService.addMarkerHistory(historyMarker);

      if (!currentContext.mounted) return;
      Provider.of<ImagesState>(currentContext, listen: false).setStartingImagePath("");
      Provider.of<ImagesState>(currentContext, listen: false).setEndingImagePath("");

      MapState.handleDeleting("Saving marker to history...");

      debugPrint("Saving marker: ${historyMarker.toJson()}");
    } else {
      debugPrint('Custom Marker is null');
    }
  }
}
