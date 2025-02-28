import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:travel_guard/state/images_state.dart';
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
  List<int> list0fDistances = [
    1000,
    5000,
    10000
  ];

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
                      isSelected: selectedIndex == list0fDistances.indexOf(distance),
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
            Center(
              child: Container(
                  alignment: Alignment.center,
                  width: 100,
                  height: 50,
                  margin: EdgeInsets.only(top: 190),
                  child: TextButton(
                      onPressed: () async {
                        debugPrint("Add photo");
                        final image = await _pickImageFromCamera();
                        final imagePath = image ?? "";
                        if (!context.mounted) return;
                        Provider.of<ImagesState>(context, listen: false).setStartingImagePath(imagePath);
                      },
                      child: Text(
                        "Add photo",
                        style: GoogleFonts.staatliches(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ))),
            ),
            Container(
              padding: EdgeInsets.only(top: 300),
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
      ),
    );
  }
}

Future<String?> _pickImageFromCamera() async {
  final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
  if (pickedFile == null) return null;
  String encodedImageString = base64.encode(File(pickedFile.path).readAsBytesSync().toList());
  return encodedImageString;
}
