import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sensors_platform_interface/flutter_sensors_platform_interface.dart';

/// The iOS implementation of [FlutterSensorsPlatform].
class FlutterSensorsIOS extends FlutterSensorsPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_sensors_ios');

  /// Registers this class as the default instance of [FlutterSensorsPlatform]
  static void registerWith() {
    FlutterSensorsPlatform.instance = FlutterSensorsIOS();
  }

  @override
  Future<String?> getPlatformName() {
    return methodChannel.invokeMethod<String>('getPlatformName');
  }
}
