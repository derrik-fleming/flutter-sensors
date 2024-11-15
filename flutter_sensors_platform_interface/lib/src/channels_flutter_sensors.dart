import 'package:flutter/foundation.dart' show visibleForTesting;
import 'package:flutter/services.dart';
import 'package:flutter_sensors_platform_interface/flutter_sensors_platform_interface.dart';

/// An implementation of [FlutterSensorsPlatform] that uses method channels.
class ChannelsFlutterSensors extends FlutterSensorsPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_sensors');

  /// The event channel used to recieve events from the native platform
  @visibleForTesting
  final EventChannel eventChannel =
      const EventChannel('flutter_sensors/sensor_events');

  @override
  Future<String?> getPlatformName() {
    return methodChannel.invokeMethod<String>('getPlatformName');
  }

  @override
  Stream<SensorData> get sensorData {
    throw UnimplementedError();
  }
}
