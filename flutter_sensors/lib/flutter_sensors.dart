import 'package:flutter_sensors_platform_interface/flutter_sensors_platform_interface.dart';

export 'package:flutter_sensors_platform_interface/src/gyro_sensor_data.dart';
export 'package:flutter_sensors_platform_interface/src/sensor_data.dart';

FlutterSensorsPlatform get _platform => FlutterSensorsPlatform.instance;

/// Returns the name of the current platform.
Future<String> getPlatformName() async {
  final platformName = await _platform.getPlatformName();
  if (platformName == null) throw Exception('Unable to get platform name.');
  return platformName;
}

/// A stream of [SensorData] from the platform
Stream<SensorData> get sensorData => _platform.sensorData;
