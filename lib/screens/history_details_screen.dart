import 'package:flutter/material.dart';
import 'package:travel_guard/models/marker_history.dart';
import 'package:travel_guard/widgets/history_deatails/history_details_logo.dart';
import 'package:travel_guard/widgets/history_deatails/history_details_statistics.dart';
import 'package:travel_guard/widgets/history_deatails/history_details_title.dart';

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
              HistoryDetailsTitle(),
              HistoryDetailsLogo(),
              HistoryDetailsStatistics(widget: widget)
            ],
          ),
        ),
      ),
    );
  }
}
