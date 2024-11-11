import 'package:flutter_sensors_platform_interface/flutter_sensors_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';

class FlutterSensorsMock extends FlutterSensorsPlatform {
  static const mockPlatformName = 'Mock';

  @override
  Future<String?> getPlatformName() async => mockPlatformName;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('FlutterSensorsPlatformInterface', () {
    late FlutterSensorsPlatform flutterSensorsPlatform;

    setUp(() {
      flutterSensorsPlatform = FlutterSensorsMock();
      FlutterSensorsPlatform.instance = flutterSensorsPlatform;
    });

    group('getPlatformName', () {
      test('returns correct name', () async {
        expect(
          await FlutterSensorsPlatform.instance.getPlatformName(),
          equals(FlutterSensorsMock.mockPlatformName),
        );
      });
    });
  });
}
