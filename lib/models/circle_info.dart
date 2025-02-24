import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class CircleInfo {
  final GeoPoint centerPoint;
  final double radius;

  CircleInfo({
    required this.centerPoint,
    required this.radius,
  });

  Map<String, dynamic> toJson() {
    return {
      'centerPoint': centerPoint.toJson(),
      'radius': radius,
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
