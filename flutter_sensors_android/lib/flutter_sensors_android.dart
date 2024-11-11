import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sensors_platform_interface/flutter_sensors_platform_interface.dart';

/// The Android implementation of [FlutterSensorsPlatform].
class FlutterSensorsAndroid extends FlutterSensorsPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_sensors_android');

  /// Registers this class as the default instance of [FlutterSensorsPlatform]
  static void registerWith() {
    FlutterSensorsPlatform.instance = FlutterSensorsAndroid();
  }

  @override
  Future<String?> getPlatformName() {
    return methodChannel.invokeMethod<String>('getPlatformName');
  }
}
