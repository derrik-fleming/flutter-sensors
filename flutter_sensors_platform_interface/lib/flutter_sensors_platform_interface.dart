import 'package:flutter_sensors_platform_interface/src/channels_flutter_sensors.dart';
import 'package:flutter_sensors_platform_interface/src/sensor_data.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

export 'package:flutter_sensors_platform_interface/src/gyro_sensor_data.dart';
export 'package:flutter_sensors_platform_interface/src/sensor_data.dart';

/// The interface that implementations of flutter_sensors must implement.
///
/// Platform implementations should extend this class
/// rather than implement it as `FlutterSensors`.
/// Extending this class (using `extends`) ensures that the subclass will get
/// the default implementation, while platform implementations that `implements`
///  this interface will be broken by newly added [FlutterSensorsPlatform]
///  methods.
abstract class FlutterSensorsPlatform extends PlatformInterface {
  /// Constructs a FlutterSensorsPlatform.
  FlutterSensorsPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterSensorsPlatform _instance = ChannelsFlutterSensors();

  /// The default instance of [FlutterSensorsPlatform] to use.
  ///
  /// Defaults to [ChannelsFlutterSensors].
  static FlutterSensorsPlatform get instance => _instance;

  /// Platform-specific plugins should set this with their own platform-specific
  /// class that extends [FlutterSensorsPlatform] when they register themselves.
  static set instance(FlutterSensorsPlatform instance) {
    PlatformInterface.verify(instance, _token);
    _instance = instance;
  }

  /// Return the current platform name.
  Future<String?> getPlatformName();

  /// Return a stream of [SensorData] from the native platform
  Stream<SensorData> get sensorData;
}
