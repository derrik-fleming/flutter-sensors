import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sensors_platform_interface/flutter_sensors_platform_interface.dart';

/// The Android implementation of [FlutterSensorsPlatform].
class FlutterSensorsAndroid extends FlutterSensorsPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_sensors_android');

  ///
  @visibleForTesting
  static const EventChannel sensorChannel =
      EventChannel('flutter_sensors_android/sensor_events');

  /// Registers this class as the default instance of [FlutterSensorsPlatform]
  static void registerWith() {
    FlutterSensorsPlatform.instance = FlutterSensorsAndroid();
  }

  @override
  Future<String?> getPlatformName() {
    return methodChannel.invokeMethod<String>('getPlatformName');
  }

  @override
  Stream<SensorData> get sensorData =>
      sensorChannel.receiveBroadcastStream().map((event) {
        return SensorData.fromJson(
          jsonDecode(event.toString()) as Map<String, dynamic>,
        );
      });
}
