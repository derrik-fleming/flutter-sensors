import 'package:flutter_sensors_platform_interface/flutter_sensors_platform_interface.dart';

FlutterSensorsPlatform get _platform => FlutterSensorsPlatform.instance;

/// Returns the name of the current platform.
Future<String> getPlatformName() async {
  final platformName = await _platform.getPlatformName();
  if (platformName == null) throw Exception('Unable to get platform name.');
  return platformName;
}
