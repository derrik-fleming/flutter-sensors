import 'package:flutter/services.dart';
import 'package:flutter_sensors_android/flutter_sensors_android.dart';
import 'package:flutter_sensors_platform_interface/flutter_sensors_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('FlutterSensorsAndroid', () {
    const kPlatformName = 'Android';
    late FlutterSensorsAndroid flutterSensors;
    late List<MethodCall> log;

    setUp(() async {
      flutterSensors = FlutterSensorsAndroid();

      log = <MethodCall>[];
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(flutterSensors.methodChannel,
              (methodCall) async {
        log.add(methodCall);
        switch (methodCall.method) {
          case 'getPlatformName':
            return kPlatformName;
          default:
            return null;
        }
      });
    });

    test('can be registered', () {
      FlutterSensorsAndroid.registerWith();
      expect(FlutterSensorsPlatform.instance, isA<FlutterSensorsAndroid>());
    });

    test('getPlatformName returns correct name', () async {
      final name = await flutterSensors.getPlatformName();
      expect(
        log,
        <Matcher>[isMethodCall('getPlatformName', arguments: null)],
      );
      expect(name, equals(kPlatformName));
    });
  });
}
