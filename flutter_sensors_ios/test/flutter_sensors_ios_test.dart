import 'package:flutter/services.dart';
import 'package:flutter_sensors_ios/flutter_sensors_ios.dart';
import 'package:flutter_sensors_platform_interface/flutter_sensors_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('FlutterSensorsIOS', () {
    const kPlatformName = 'iOS';
    late FlutterSensorsIOS flutterSensors;
    late List<MethodCall> log;

    setUp(() async {
      flutterSensors = FlutterSensorsIOS();

      log = <MethodCall>[];
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(flutterSensors.methodChannel, (methodCall) async {
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
      FlutterSensorsIOS.registerWith();
      expect(FlutterSensorsPlatform.instance, isA<FlutterSensorsIOS>());
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
