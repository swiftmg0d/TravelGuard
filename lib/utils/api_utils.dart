import 'package:firebase_remote_config/firebase_remote_config.dart';

class ApiUtils {
  static Future<String> getApiKey(String apiKey) async {
    final remoteConfig = FirebaseRemoteConfig.instance;

    await remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: Duration(seconds: 10),
        minimumFetchInterval: Duration.zero,
      ),
    );

    await remoteConfig.fetchAndActivate();

    return remoteConfig.getString(apiKey);
  }
}
