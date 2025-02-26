class MarkerHistory {
  final String startingAddress;
  final String endingAddress;
  final DateTime created;
  final DateTime finished;
  final double distance;
  final double duration;

  MarkerHistory({required this.startingAddress, required this.endingAddress, required this.created, required this.finished, required this.distance, required this.duration});

  factory MarkerHistory.fromMap(Map<String, dynamic> map) {
    return MarkerHistory(
      startingAddress: map['startingAddress'],
      endingAddress: map['endingAddress'],
      created: DateTime.parse(map['created']),
      finished: DateTime.parse(map['finished']),
      distance: (map['distance'] as num).toDouble(),
      duration: (map['duration'] as num).toDouble(),
    );
  }

  toJson() {
    return {
      'startingAddress': startingAddress,
      'endingAddress': endingAddress,
      'created': created.toIso8601String(),
      'finished': finished.toIso8601String(),
      'distance': distance,
      'duration': duration,
    };
  }
}
