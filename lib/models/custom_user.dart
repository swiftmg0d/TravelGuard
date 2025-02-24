import 'package:travel_guard/models/custom_marker.dart';

class CustomUser {
  final String? id;
  final String email;
  final String password;
  List<CustomMarker> markers = [];
  List<CustomMarker> history = [];

  CustomUser({required this.id, required this.email, required this.password});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'markers': markers.map((e) => e.toJson()).toList(),
      'history': history.map((e) => e.toJson()).toList(),
    };
  }
}
