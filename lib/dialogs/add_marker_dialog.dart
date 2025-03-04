import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:travel_guard/widgets/add_marker/add_marker_distance_button.dart';
import 'package:travel_guard/widgets/add_marker/add_marker_dialog_cancel_button.dart';
import 'package:travel_guard/widgets/add_marker/add_marker_dialog_confirm_button.dart';
import 'package:travel_guard/widgets/add_marker/add_marker_dialog_logo.dart';
import 'package:travel_guard/widgets/add_marker/add_marker_dialog_subtitle.dart';
import 'package:travel_guard/widgets/add_marker/add_marker_dialog_title.dart';
import 'package:travel_guard/widgets/camera/camera_add_photo.dart';

class AddMarkerDialog extends StatefulWidget {
  final GeoPoint value;
  final MapController controller;

  const AddMarkerDialog({
    super.key,
    required this.value,
    required this.controller,
  });

  @override
  State<AddMarkerDialog> createState() => _AddMarkerDialogState();
}

class _AddMarkerDialogState extends State<AddMarkerDialog> {
  int selectedIndex = -1;
  int distance = 0;
  List<int> list0fDistances = [1000, 5000, 10000];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color.fromARGB(255, 244, 251, 250),
      content: SizedBox(
        height: 370,
        child: Stack(
          children: <Widget>[
            AddMarkerDialogLogo(),
            AddMarkerDialogTitle(),
            AddMarkerDialogSubTitle(),
            Container(
              padding: EdgeInsets.only(top: 130),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ...list0fDistances.map((distance) {
                    return DistanceButton(
                      distance: distance,
                      isSelected:
                          selectedIndex == list0fDistances.indexOf(distance),
                      onSelect: () {
                        setState(() {
                          selectedIndex = list0fDistances.indexOf(distance);
                          this.distance = distance;
                        });
                      },
                    );
                  }),
                ],
              ),
            ),
            SizedBox(height: 100),
            CameraAddPhotoWidget(topMargin: 190, type: 'addMarker'),
            Container(
              padding: EdgeInsets.only(top: 300),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AddMarkerDialogCancelButton(),
                  AddMarkerDialogConfirmButton(
                      selectedIndex: selectedIndex,
                      widget: widget,
                      distance: distance)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
