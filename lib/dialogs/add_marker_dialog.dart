import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:travel_guard/widgets/add_marker/marker_distance_button.dart';
import 'package:travel_guard/widgets/add_marker/marker_dialog_cancel_button.dart';
import 'package:travel_guard/widgets/add_marker/marker_dialog_confirm_button.dart';
import 'package:travel_guard/widgets/add_marker/marker_dialog_logo.dart';
import 'package:travel_guard/widgets/add_marker/marker_dialog_subtitle.dart';
import 'package:travel_guard/widgets/add_marker/marker_dialog_title.dart';

class AddMarkerDialog extends StatefulWidget {
  final GeoPoint value;
  final MapController controller;

  const AddMarkerDialog({
    Key? key,
    required this.value,
    required this.controller,
  }) : super(key: key);

  @override
  State<AddMarkerDialog> createState() => _AddMarkerDialogState();
}

class _AddMarkerDialogState extends State<AddMarkerDialog> {
  int selectedIndex = -1;
  int distance = 0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color.fromARGB(255, 244, 251, 250),
      content: Stack(
        children: <Widget>[
          AddMarkerDialogLogo(),
          AddMarkerDialogTitle(),
          AddMarkerDialogSubTitle(),
          Container(
            padding: EdgeInsets.only(top: 130),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DistanceButton(
                  distance: 1000,
                  isSelected: selectedIndex == 0,
                  onSelect: () {
                    setState(() {
                      selectedIndex = 0;
                      distance = 1000;
                    });
                  },
                ),
                DistanceButton(
                  distance: 5000,
                  isSelected: selectedIndex == 1,
                  onSelect: () {
                    setState(() {
                      selectedIndex = 1;
                      distance = 5000;
                    });
                  },
                ),
                DistanceButton(
                  distance: 10000,
                  isSelected: selectedIndex == 2,
                  onSelect: () {
                    setState(() {
                      selectedIndex = 2;
                      distance = 10000;
                    });
                  },
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 250),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AddMarkerDialogCancelButton(),
                AddMarkerDialogConfirmButton(selectedIndex: selectedIndex, widget: widget, distance: distance)
              ],
            ),
          )
        ],
      ),
    );
  }
}
