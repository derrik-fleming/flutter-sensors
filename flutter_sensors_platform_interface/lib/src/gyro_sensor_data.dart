import 'package:flutter_sensors_platform_interface/src/sensor_data.dart';
import 'package:flutter_sensors_platform_interface/src/sensor_type.dart';

/// Encapsulates the data obtained from a [SensorType.gyro]
class GyroSensorData extends SensorData {
  /// Creates a new instance of [GyroSensorData]
  GyroSensorData({
    required this.x,
    required this.y,
    required this.z,
  });

  /// Creates a new instance of [GyroSensorData] from a decoded JSON blob
  factory GyroSensorData.fromJson(Map<String, dynamic> json) {
    if (json['x'] is num && json['y'] is num && json['z'] is num) {
      return GyroSensorData(
        x: (json['x'] as num).toDouble(),
        y: (json['y'] as num).toDouble(),
        z: (json['z'] as num).toDouble(),
      );
    } else {
      throw const FormatException('Invalid format for Sensor Data.');
    }
  }

  /// The X-axis value for [SensorType.gyro] [SensorData]
  final double x;

  /// the Y-axis value for [SensorType.gyro] [SensorData]
  final double y;

  /// The Z-axis value for [SensorType.gyro] [SensorData]
  final double z;
}
