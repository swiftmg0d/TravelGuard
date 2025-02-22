import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:travel_guard/models/circle_info.dart';
import 'package:travel_guard/models/enum/status.dart';
import 'package:travel_guard/models/marker_info.dart';

class CustomMarker {
  final MarkerInfo markerInfo;
  final CircleInfo circleInfo;
  final Status status = Status.created;
  final DateTime created = DateTime.now();
  final DateTime? finished;

  CustomMarker({required this.markerInfo, required this.circleInfo, required this.finished});

  Map<String, dynamic> toJson() {
    return {
      'markerInfo': markerInfo.toJson(),
      'circleInfo': circleInfo.toJson(),
      'status': status.toString().split('.').last,
      'created': created.toIso8601String(),
      'finished': finished?.toIso8601String(),
    };
  }

  static CustomMarker fromMap(Map<String, dynamic> marker) {
    return CustomMarker(
      markerInfo: MarkerInfo(
        point: GeoPoint(
          latitude: marker['markerInfo']['point']['latitude'] as double,
          longitude: marker['markerInfo']['point']['longitude'] as double,
        ),
        angle: marker['markerInfo']['angle'] != null ? (marker['markerInfo']['angle'] as num).toDouble() : null,
      ),
      circleInfo: CircleInfo(
        centerPoint: GeoPoint(
          latitude: marker['circleInfo']['centerPoint']['latitude'] as double,
          longitude: marker['circleInfo']['centerPoint']['longitude'] as double,
        ),
        radius: (marker['circleInfo']['radius'] as num).toDouble(),
        strokeWidth: (marker['circleInfo']['strokeWidth'] as num).toDouble(),
      ),
      finished: marker['finished'] != null ? DateTime.parse(marker['finished']) : null,
    );
  }
}
