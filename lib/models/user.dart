import 'package:flutter_map/flutter_map.dart';

class User {
  final String email;
  final String password;
  List<Marker> markers = [];

  User(this.email, this.password);
}
