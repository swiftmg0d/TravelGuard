import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class CustomGeopoint {
  final double latitude;
  final double longitude;

  CustomGeopoint({required this.latitude, required this.longitude});

  factory CustomGeopoint.fromMap(Map<String, dynamic> map) {
    return CustomGeopoint(
      latitude: (map['latitude'] as num).toDouble(),
      longitude: (map['longitude'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  GeoPoint toGeoPoint() {
    return GeoPoint(latitude: latitude, longitude: longitude);
  }
}
