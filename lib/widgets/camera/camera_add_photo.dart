import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:travel_guard/dialogs/loading_dialog.dart';
import 'package:travel_guard/providers/image_provider.dart';

class CameraAddPhotoWidget extends StatelessWidget {
  final double topMargin;
  final String type;
  const CameraAddPhotoWidget({
    super.key,
    required this.topMargin,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          margin: EdgeInsets.only(top: topMargin),
          alignment: Alignment.center,
          width: 100,
          height: 50,
          child: TextButton(
              onPressed: () async {
                debugPrint("Add photo");
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) =>
                      const LoadingDialog(message: 'Loading camera...'),
                );
                final image = await _pickImageFromCamera();
                if (!context.mounted) return;
                Navigator.pop(context);
                final imagePath = image ?? "";
                if (!context.mounted) return;
                type == "starting"
                    ? Provider.of<ImageState>(context, listen: false)
                        .setStartingImagePath(imagePath)
                    : Provider.of<ImageState>(context, listen: false)
                        .setEndingImagePath(imagePath);
              },
              child: Text(
                "Add photo",
                style: GoogleFonts.staatliches(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ))),
    );
  }
}

Future<String?> _pickImageFromCamera() async {
  final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
  if (pickedFile == null) return null;
  String encodedImageString =
      base64.encode(File(pickedFile.path).readAsBytesSync().toList());
  return encodedImageString;
}
