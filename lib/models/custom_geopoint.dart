class CustomGeopoint {
  final double latitude;
  final double longitude;

  CustomGeopoint({required this.latitude, required this.longitude});

  factory CustomGeopoint.fromMap(Map<String, dynamic> map) {
    return CustomGeopoint(
      latitude: map['latitude'],
      longitude: map['longitude'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
