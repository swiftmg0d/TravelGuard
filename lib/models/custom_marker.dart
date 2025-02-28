import 'package:geolocator/geolocator.dart';
import 'package:travel_guard/models/custom_geopoint.dart';
import 'package:travel_guard/models/enum/status.dart';

class CustomMarker {
  final CustomGeopoint centarPoint;
  final double radius;
  final Status status = Status.created;
  final DateTime created;
  final CustomGeopoint startingPosition;
  final String? startingImage;

  CustomMarker({
    required this.centarPoint,
    required this.radius,
    required this.startingPosition,
    this.startingImage,
    DateTime? created,
  }) : created = created ?? DateTime.now();
  Map<String, dynamic> toJson() {
    return {
      'centarPoint': centarPoint.toJson(),
      'radius': radius,
      'status': status.toString().split('.').last,
      'created': created.toIso8601String(),
      'startingPosition': startingPosition.toJson(),
      'startingImage': startingImage,
    };
  }

  static CustomMarker fromMap(Map<String, dynamic> marker) {
    return CustomMarker(
      centarPoint: CustomGeopoint.fromMap(marker['centarPoint']),
      radius: (marker['radius'] as num).toDouble(),
      startingPosition: CustomGeopoint.fromMap(marker['startingPosition']),
      created: DateTime.parse(marker['created']),
      startingImage: marker['startingImage'],
    );
  }

  double distance() {
    return Geolocator.distanceBetween(centarPoint.latitude, centarPoint.longitude, startingPosition.latitude, startingPosition.longitude);
  }

  static String timeFromTo(DateTime created, DateTime finished) {
    Duration difference = finished.difference(created);

    int differenceInMinutes = difference.inMinutes.abs();
    int diffrenceInHours = difference.inHours.abs();
    final output = diffrenceInHours == 0 ? "$differenceInMinutes min" : "$diffrenceInHours h $differenceInMinutes min";

    return output;
  }
}
