import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class MarkerInfo {
  final GeoPoint point;
  final double? angle;

  MarkerInfo({required this.point, required this.angle});

  Map<String, dynamic> toJson() {
    return {
      'point': point.toJson(),
      'angle': angle,
    };
  }
}

extension on GeoPoint {
  toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
