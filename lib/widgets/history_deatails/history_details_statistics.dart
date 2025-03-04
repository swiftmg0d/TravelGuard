import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_guard/models/custom_address.dart';
import 'package:travel_guard/screens/history_details_screen.dart';
import 'package:travel_guard/utils/history_utils.dart';
import 'package:travel_guard/widgets/scaffold_messenger/custom_scaffold_messenger.dart';

class HistoryDetailsStatistics extends StatelessWidget {
  const HistoryDetailsStatistics({
    super.key,
    required this.widget,
  });

  final HistoryDetailsScreen widget;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 310),
        child: Column(
          children: [
            const SizedBox(height: 60),
            Text("Starting Address",
                style: GoogleFonts.staatliches(
                    fontSize: 21, color: Color.fromARGB(255, 11, 42, 41)),
                textAlign: TextAlign.center),
            const SizedBox(height: 10),
            ImageAddressPreview(
                customAddress: CustomAddress(
                    address: widget.markerHistory.startingAddress,
                    image: widget.markerHistory.startingImage!,
                    type: "starting")),
            const SizedBox(height: 20),
            Text("Destination Address",
                style: GoogleFonts.staatliches(
                    fontSize: 21, color: Color.fromARGB(255, 11, 42, 41)),
                textAlign: TextAlign.center),
            const SizedBox(height: 10),
            ImageAddressPreview(
                customAddress: CustomAddress(
                    address: widget.markerHistory.destinationAddress,
                    image: widget.markerHistory.endingImage!,
                    type: "destination")),
            SizedBox(height: 20),
            Text("Statistics",
                style: GoogleFonts.staatliches(
                    fontSize: 21, color: Color.fromARGB(255, 11, 42, 41)),
                textAlign: TextAlign.center),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    "Distance: ${HistoryUtils.getDistance(widget.markerHistory.distance)}",
                    style: GoogleFonts.staatliches(
                        fontSize: 19, color: Color.fromARGB(255, 11, 70, 68)),
                    textAlign: TextAlign.center),
                const SizedBox(width: 20),
                Text("Time: ${widget.markerHistory.duration}",
                    style: GoogleFonts.staatliches(
                        fontSize: 19, color: Color.fromARGB(255, 11, 70, 68)),
                    textAlign: TextAlign.center),
              ],
            ),
            const SizedBox(height: 10),
            Text(
                "Started: ${HistoryUtils.formatDateTime(widget.markerHistory.started)}",
                style: GoogleFonts.staatliches(
                    fontSize: 19, color: Color.fromARGB(255, 11, 70, 68)),
                textAlign: TextAlign.center),
            Text(
                "Finished: ${HistoryUtils.formatDateTime(widget.markerHistory.finished)}",
                style: GoogleFonts.staatliches(
                    fontSize: 19, color: Color.fromARGB(255, 11, 70, 68)),
                textAlign: TextAlign.center),
            SizedBox(height: 65),
            InfoTip(),
            SizedBox(height: 10),
            SizedBox(
              width: 230,
              child: Text(
                textAlign: TextAlign.center,
                "You can view the images by clicking on the addressess",
                style: GoogleFonts.staatliches(
                  color: Color.fromARGB(255, 19, 52, 50),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class InfoTip extends StatelessWidget {
  const InfoTip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 25,
          height: 25,
          decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle),
          child: Center(
            child: Text(
              "!",
              style: GoogleFonts.staatliches(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SizedBox(width: 5),
        Text(
          "TIP",
          style: GoogleFonts.staatliches(
            color: Color.fromARGB(255, 19, 52, 50),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}

class ImageAddressPreview extends StatelessWidget {
  const ImageAddressPreview({
    super.key,
    required this.customAddress,
  });

  final CustomAddress customAddress;

  @override
  Widget build(BuildContext context) {
    debugPrint("${customAddress.toJson()}");
    return InkWell(
        onTap: () {
          if (customAddress.image.isEmpty) {
            debugPrint("No image available");
            CustomScaffoldMessenger.show(
              context,
              "No image available",
              const Color.fromARGB(255, 47, 1, 1),
            );
            return;
          } else {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: Image.memory(base64.decode(customAddress.image)),
                    ),
                  );
                });
          }
        },
        child: SizedBox(
          width: 300,
          child: Text(customAddress.address,
              style: GoogleFonts.staatliches(
                  fontSize: 19, color: Color.fromARGB(255, 11, 70, 68)),
              textAlign: TextAlign.center),
        ));
  }
}
