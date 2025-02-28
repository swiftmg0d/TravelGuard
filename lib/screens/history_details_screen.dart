import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:travel_guard/models/marker_history.dart';
import 'package:travel_guard/utils/history_utils.dart';

class HistoryDetailsScreen extends StatefulWidget {
  final MarkerHistory markerHistory;

  const HistoryDetailsScreen({
    super.key,
    required this.markerHistory,
  });

  @override
  State<HistoryDetailsScreen> createState() => _HistoryDetailsScreenState();
}

class _HistoryDetailsScreenState extends State<HistoryDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Material(
        child: Container(
          color: Color.fromARGB(255, 244, 251, 250),
          child: Stack(
            children: [
              SizedBox(
                height: 200,
                child: Center(
                  child: Text(
                    'History Details',
                    style: GoogleFonts.staatliches(fontSize: 25, color: Color.fromARGB(255, 19, 50, 49)),
                  ),
                ),
              ),
              Center(child: Container(margin: EdgeInsets.only(bottom: 600), child: Lottie.asset("assets/icons_json/history_details_logo.json"))),
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 270),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Text("Starting Address", style: GoogleFonts.staatliches(fontSize: 21, color: Color.fromARGB(255, 11, 42, 41)), textAlign: TextAlign.center),
                      const SizedBox(height: 10),
                      InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: Container(
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                                      child: Image.memory(base64.decode(widget.markerHistory.startingImage!)),
                                    ),
                                  );
                                });
                          },
                          child: Text(widget.markerHistory.startingAddress, style: GoogleFonts.staatliches(fontSize: 19, color: Color.fromARGB(255, 11, 70, 68)), textAlign: TextAlign.center)),
                      const SizedBox(height: 20),
                      Text("Destination Address", style: GoogleFonts.staatliches(fontSize: 21, color: Color.fromARGB(255, 11, 42, 41)), textAlign: TextAlign.center),
                      const SizedBox(height: 10),
                      InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: Container(
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                                      child: Image.memory(base64.decode(widget.markerHistory.destinationAddress!)),
                                    ),
                                  );
                                });
                          },
                          child: Text(widget.markerHistory.destinationAddress, style: GoogleFonts.staatliches(fontSize: 19, color: Color.fromARGB(255, 11, 70, 68)), textAlign: TextAlign.center)),
                      SizedBox(height: 20),
                      Text("Statistics", style: GoogleFonts.staatliches(fontSize: 21, color: Color.fromARGB(255, 11, 42, 41)), textAlign: TextAlign.center),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Distance: ${HistoryUtils.getDistance(widget.markerHistory.distance)}", style: GoogleFonts.staatliches(fontSize: 19, color: Color.fromARGB(255, 11, 70, 68)), textAlign: TextAlign.center),
                          const SizedBox(width: 20),
                          Text("Time: ${widget.markerHistory.duration}", style: GoogleFonts.staatliches(fontSize: 19, color: Color.fromARGB(255, 11, 70, 68)), textAlign: TextAlign.center),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text("Started: ${HistoryUtils.formatDateTime(widget.markerHistory.started)}", style: GoogleFonts.staatliches(fontSize: 19, color: Color.fromARGB(255, 11, 70, 68)), textAlign: TextAlign.center),
                      Text("Finished: ${HistoryUtils.formatDateTime(widget.markerHistory.finished)}", style: GoogleFonts.staatliches(fontSize: 19, color: Color.fromARGB(255, 11, 70, 68)), textAlign: TextAlign.center),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: 25,
                            height: 25,
                            decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                            child: Center(
                              child: Text(
                                "!",
                                style: GoogleFonts.staatliches(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          SizedBox(width: 5),
                          Text(
                            "TIP: You can view the images by clicking on the addresses",
                            style: GoogleFonts.staatliches(
                              color: Color.fromARGB(255, 19, 52, 50),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
