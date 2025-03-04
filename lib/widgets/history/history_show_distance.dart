import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_guard/models/marker_history.dart';
import 'package:travel_guard/utils/history_utils.dart';

class ShowDistanceWidget extends StatelessWidget {
  const ShowDistanceWidget({
    super.key,
    required this.historyItem,
  });

  final dynamic historyItem;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: [
        Text(
          "${HistoryUtils.getDistance(historyItem['distance'])}",
          style: GoogleFonts.staatliches(color: Colors.white, fontSize: 16),
        ),
        Text(
          HistoryUtils.timeFromTo(DateTime.parse(historyItem['started']),
              DateTime.parse(historyItem['finished'])),
          style: TextStyle(color: Colors.white),
        ),
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, '/history_details',
                arguments: MarkerHistory.fromMap(historyItem));
          },
          child: Text(
            "Details",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }
}
