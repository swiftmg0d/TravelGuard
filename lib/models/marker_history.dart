class MarkerHistory {
  final String startingAddress;
  final String destinationAddress;
  final DateTime started;
  final DateTime finished;
  final double distance;
  final String duration;
  final String? startingImage;
  final String? endingImage;

  MarkerHistory(
      {required this.startingAddress,
      required this.destinationAddress,
      required this.started,
      required this.finished,
      required this.distance,
      required this.duration,
      this.startingImage,
      this.endingImage});

  factory MarkerHistory.fromMap(Map<String, dynamic> map) {
    return MarkerHistory(
      startingAddress: map['startingAddress'],
      destinationAddress: map['destinationAddress'],
      started: DateTime.parse(map['started']),
      finished: DateTime.parse(map['finished']),
      distance: (map['distance'] as num).toDouble(),
      duration: map['duration'],
      startingImage: map['startingImage'],
      endingImage: map['endingImage'],
    );
  }

  toJson() {
    return {
      'startingAddress': startingAddress,
      'destinationAddress': destinationAddress,
      'started': started.toIso8601String(),
      'finished': finished.toIso8601String(),
      'distance': distance,
      'duration': duration,
      'startingImage': startingImage,
      'endingImage': endingImage,
    };
  }
}
