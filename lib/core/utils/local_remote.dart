import 'package:firebase_remote_config/firebase_remote_config.dart';

class LocalRemote {
  final remoteConfig = FirebaseRemoteConfig.instance;

  LocalRemote() {
    _init();
  }
  void _init() async {
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(hours: 1),
    ));
    remoteConfig.fetch();
    remoteConfig.activate();
  }

  bool getTaskColour() {
    return remoteConfig.getBool('task_colour');
  }
}
