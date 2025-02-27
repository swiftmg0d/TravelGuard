class MarkerHistory {
  final String startingAddress;
  final String destinationAddress;
  final DateTime started;
  final DateTime finished;
  final double distance;
  final int duration;

  MarkerHistory({required this.startingAddress, required this.destinationAddress, required this.started, required this.finished, required this.distance, required this.duration});

  factory MarkerHistory.fromMap(Map<String, dynamic> map) {
    return MarkerHistory(
      startingAddress: map['startingAddress'],
      destinationAddress: map['destinationAddress'],
      started: DateTime.parse(map['started']),
      finished: DateTime.parse(map['finished']),
      distance: (map['distance'] as num).toDouble(),
      duration: map['duration'] as int,
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
    };
  }
}
