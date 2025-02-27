import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:travel_guard/state/map_state.dart';
import 'package:travel_guard/widgets/destination_reached/destination_reached_dialog_delete_button.dart';
import 'package:travel_guard/widgets/destination_reached/destination_reached_dialog_logo.dart';
import 'package:travel_guard/widgets/destination_reached/destination_reached_dialog_save_button.dart';
import 'package:cyrtranslit/cyrtranslit.dart';

bool isCyrillic(String text) {
  final cyrillicRegex = RegExp(r'[\u0400-\u04FF]');
  return cyrillicRegex.hasMatch(text);
}

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

    final latinStartinLocationName = isCyrillic(widget.startinLocation) ? cyr2Lat(widget.startinLocation, langCode: "mk") : widget.startinLocation;
    final latinEndinLocationName = isCyrillic(widget.endinLocation) ? cyr2Lat(widget.endinLocation, langCode: "mk") : widget.endinLocation;

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
        content: SizedBox(
          height: 400,
          child: Stack(children: [
            DestinationReachedDialoglogo(),
            Column(mainAxisSize: MainAxisSize.min, children: [
              Text('You have reached your destination at $latinEndinLocationName',
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
                  DestinationReachedDialogSaveButton(
                    startingAddress: latinStartinLocationName,
                    destinationAddress: latinEndinLocationName,
                    started: mapState.customMarker!.created,
                  ),
                  DestinationReachedDialogDeleteButton()
                ],
              )
            ]),
          ]),
        ),
      ),
    );
  }
}
