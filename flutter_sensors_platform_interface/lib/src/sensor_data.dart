import 'package:flutter_sensors_platform_interface/src/gyro_sensor_data.dart';
import 'package:flutter_sensors_platform_interface/src/sensor_type.dart';

///
abstract class SensorData {
  ///
  SensorData();

  /// Creates an instance of SensorData from a decoded JSON blob
  factory SensorData.fromJson(Map<String, dynamic> json) {
    final type = SensorType.parse(json['type'].toString());
    return switch (type) {
      SensorType.gyro => GyroSensorData.fromJson(json),
    };
  }
}
