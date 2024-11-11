import 'package:flutter_sensors/flutter_sensors.dart';
import 'package:flutter_sensors_platform_interface/flutter_sensors_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterSensorsPlatform extends Mock
    with MockPlatformInterfaceMixin
    implements FlutterSensorsPlatform {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('FlutterSensors', () {
    late FlutterSensorsPlatform flutterSensorsPlatform;

    setUp(() {
      flutterSensorsPlatform = MockFlutterSensorsPlatform();
      FlutterSensorsPlatform.instance = flutterSensorsPlatform;
    });

    group('getPlatformName', () {
      test('returns correct name when platform implementation exists',
          () async {
        const platformName = '__test_platform__';
        when(
          () => flutterSensorsPlatform.getPlatformName(),
        ).thenAnswer((_) async => platformName);

        final actualPlatformName = await getPlatformName();
        expect(actualPlatformName, equals(platformName));
      });

      test('throws exception when platform implementation is missing',
          () async {
        when(
          () => flutterSensorsPlatform.getPlatformName(),
        ).thenAnswer((_) async => null);

        expect(getPlatformName, throwsException);
      });
    });
  });
}
