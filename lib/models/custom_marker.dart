import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:travel_guard/models/custom_geopoint.dart';
import 'package:travel_guard/models/enum/status.dart';

class CustomMarker {
  final CustomGeopoint centarPoint;
  final double radius;
  final Status status = Status.created;
  final DateTime created = DateTime.now();
  final DateTime? finished;
  final CustomGeopoint startingPosition;

  CustomMarker({required this.centarPoint, required this.radius, required this.finished, required this.startingPosition});

  Map<String, dynamic> toJson() {
    return {
      'centarPoint': centarPoint.toJson(),
      'radius': radius,
      'status': status.toString().split('.').last,
      'created': created.toIso8601String(),
      'finished': finished?.toIso8601String(),
      'startingPosition': startingPosition.toJson(),
    };
  }

  static CustomMarker fromMap(Map<String, dynamic> marker) {
    return CustomMarker(
      centarPoint: CustomGeopoint.fromMap(marker['centarPoint']),
      radius: (marker['radius'] as num).toDouble(),
      finished: marker['finished'] != null ? DateTime.parse(marker['finished']) : null,
      startingPosition: CustomGeopoint.fromMap(marker['startingPosition']),
    );
  }
}
