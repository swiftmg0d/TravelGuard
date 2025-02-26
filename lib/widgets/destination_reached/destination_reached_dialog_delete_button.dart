import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:travel_guard/app_global.dart';
import 'package:travel_guard/dialogs/auth_loading_dialog.dart';
import 'package:travel_guard/models/custom_geopoint.dart';
import 'package:travel_guard/services/markers_service.dart';
import 'package:travel_guard/state/map_state.dart';

class DestinationReachedDialogDeleteButton extends StatelessWidget {
  const DestinationReachedDialogDeleteButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        handleDeleting();
      },
      child: Container(
        width: 100,
        padding: EdgeInsets.symmetric(vertical: 3, horizontal: 20),
        decoration: BoxDecoration(
          border: Border.all(color: Color.fromARGB(255, 16, 44, 43), width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          "Delete",
          textAlign: TextAlign.center,
          style: GoogleFonts.staatliches(
            color: Color.fromARGB(255, 29, 78, 74),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void handleDeleting() async {
    final currentContext = AppGlobal.navigatorKey.currentState!.context;
    final mapState = Provider.of<MapState>(currentContext, listen: false);
    showDialog(
        context: currentContext,
        builder: (context) {
          return AuthLoading(message: 'Deleting...');
        });

    if (mapState.customMarker != null) {
      final geoPoint = mapState.customMarker!.centarPoint;

      await MarkersService.removeMarker(CustomGeopoint(latitude: geoPoint.latitude, longitude: geoPoint.longitude));
      await Provider.of<MapState>(currentContext, listen: false).controller.removeMarker(mapState.customMarker!.centarPoint.toGeoPoint());
      await Provider.of<MapState>(currentContext, listen: false).controller.removeCircle(mapState.customMarker!.centarPoint.toGeoPoint().toString());

      MapState.resetConfig();

      Navigator.pop(currentContext);
      Navigator.pop(currentContext);
    }
  }
}
