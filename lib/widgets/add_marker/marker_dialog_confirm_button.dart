import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_guard/dialogs/add_marker_dialog.dart';
import 'package:travel_guard/models/circle_info.dart';
import 'package:travel_guard/models/marker_info.dart';
import 'package:travel_guard/services/markers_service.dart';

class AddMarkerDialogConfirmButton extends StatelessWidget {
  const AddMarkerDialogConfirmButton({
    super.key,
    required this.selectedIndex,
    required this.widget,
    required this.distance,
  });

  final int selectedIndex;
  final AddMarkerDialog widget;
  final int distance;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        if (selectedIndex != -1) {
          widget.controller.drawCircle(CircleOSM(
            key: widget.value.toString(),
            centerPoint: widget.value,
            radius: distance.toDouble(),
            color: Colors.transparent,
            borderColor: Color.fromARGB(255, 184, 46, 36),
            strokeWidth: 2,
          ));

          widget.controller.addMarker(
            widget.value,
            angle: pi / 4,
            markerIcon: MarkerIcon(
              icon: Icon(
                Icons.location_on_outlined,
                color: const Color.fromARGB(255, 71, 18, 14),
                size: 30,
              ),
            ),
          );

          await MarkersService.addMarker(CircleInfo(centerPoint: widget.value, radius: distance.toDouble(), strokeWidth: 2), MarkerInfo(point: widget.value, angle: pi / 2), context);

          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: Duration(seconds: 2),
              width: 200,
              backgroundColor: const Color.fromARGB(255, 47, 1, 1),
              content: Text(
                'Please select radius',
                textAlign: TextAlign.center,
                style: GoogleFonts.staatliches(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  fontSize: 20,
                  fontWeight: FontWeight.w100,
                ),
              ),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 3, horizontal: 20),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 18, 68, 64),
          border: Border.all(color: Color.fromARGB(255, 16, 44, 43), width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          "Confirm",
          style: GoogleFonts.staatliches(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
