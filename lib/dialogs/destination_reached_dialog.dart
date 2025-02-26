import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:travel_guard/models/custom_geopoint.dart';
import 'package:travel_guard/services/markers_service.dart';
import 'package:travel_guard/state/map_state.dart';
import 'package:travel_guard/widgets/destination_reached/destination_reached_dialog_delete_button.dart';
import 'package:travel_guard/widgets/destination_reached/destination_reached_dialog_logo.dart';
import 'package:travel_guard/widgets/destination_reached/destination_reached_dialog_save_button.dart';

class DestinationReachedDialog extends StatefulWidget {
  final String startinLocation;
  final String endinLocation;

  const DestinationReachedDialog({super.key, required this.startinLocation, required this.endinLocation});

  @override
  State<DestinationReachedDialog> createState() => _DestinationReachedDialogState();
}

class _DestinationReachedDialogState extends State<DestinationReachedDialog> {
  @override
  Widget build(BuildContext context) {
    final MapState mapState = Provider.of<MapState>(context, listen: false);
    return PopScope(
      canPop: false,
      child: AlertDialog(
        backgroundColor: Color.fromARGB(255, 244, 251, 250),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        title: Text('Destination Reached',
            textAlign: TextAlign.center,
            style: GoogleFonts.staatliches(
              color: Color.fromARGB(255, 0, 0, 0),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )),
        content: Container(
          height: 400,
          child: Stack(children: [
            DestinationReachedDialoglogo(),
            Container(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Text('You have reached your destination at ${widget.endinLocation}',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.staatliches(
                      color: Color.fromARGB(255, 14, 37, 36),
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(height: 260),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DestinationReachedDialogSaveButton(),
                    DestinationReachedDialogDeleteButton()
                  ],
                )
              ]),
            ),
          ]),
        ),
      ),
    );
  }
}
