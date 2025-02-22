import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class CircleInfo {
  final GeoPoint centerPoint;
  final double radius;
  final double strokeWidth;

  CircleInfo({
    required this.centerPoint,
    required this.radius,
    required this.strokeWidth,
  });

  Map<String, dynamic> toJson() {
    return {
      'centerPoint': centerPoint.toJson(),
      'radius': radius,
      'strokeWidth': strokeWidth,
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
