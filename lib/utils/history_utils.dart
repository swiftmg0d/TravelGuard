class HistoryUtils {
  static getDistance(historyItem) {
    return historyItem > 1000 ? "${(historyItem / 1000).toStringAsFixed(2)} km" : "${historyItem.toStringAsFixed(2)} m";
  }

  static String timeFromTo(DateTime created, DateTime finished) {
    Duration difference = finished.difference(created);

    int differenceInMinutes = difference.inMinutes.abs();
    int diffrenceInHours = difference.inHours.abs();
    final output = diffrenceInHours == 0 ? "$differenceInMinutes min" : "$diffrenceInHours h $differenceInMinutes min";

    return output;
  }

  static String formatDateTime(DateTime dateTime) {
    final year = dateTime.year;
    final month = dateTime.toString().split(" ")[0].split("-")[1];
    final day = dateTime.toString().split(" ")[0].split("-")[2];
    final time = dateTime.toString().split(" ")[1].substring(0, 5);
    return "${day}/${month}/${year} $time";
  }
}
