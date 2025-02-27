import 'package:geolocator/geolocator.dart';
import 'package:travel_guard/models/custom_geopoint.dart';
import 'package:travel_guard/models/enum/status.dart';

class CustomMarker {
  final CustomGeopoint centarPoint;
  final double radius;
  final Status status = Status.created;
  final DateTime created = DateTime.now();
  final CustomGeopoint startingPosition;

  CustomMarker({required this.centarPoint, required this.radius, required this.startingPosition});

  Map<String, dynamic> toJson() {
    return {
      'centarPoint': centarPoint.toJson(),
      'radius': radius,
      'status': status.toString().split('.').last,
      'created': created.toIso8601String(),
      'startingPosition': startingPosition.toJson(),
    };
  }

  static CustomMarker fromMap(Map<String, dynamic> marker) {
    return CustomMarker(
      centarPoint: CustomGeopoint.fromMap(marker['centarPoint']),
      radius: (marker['radius'] as num).toDouble(),
      startingPosition: CustomGeopoint.fromMap(marker['startingPosition']),
    );
  }

  double distance() {
    return Geolocator.distanceBetween(centarPoint.latitude, centarPoint.longitude, startingPosition.latitude, startingPosition.longitude);
  }

  static int timeFromTo(DateTime from, DateTime to) {
    final diffrence = to.difference(from).abs();
    return diffrence.inHours;
  }
}
