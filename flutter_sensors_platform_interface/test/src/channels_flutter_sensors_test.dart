import 'package:flutter/services.dart';
import 'package:flutter_sensors_platform_interface/src/channels_flutter_sensors.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const kPlatformName = 'platformName';

  group('$ChannelsFlutterSensors', () {
    late ChannelsFlutterSensors channelsFlutterSensors;
    final log = <MethodCall>[];

    setUp(() async {
      channelsFlutterSensors = ChannelsFlutterSensors();
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
        channelsFlutterSensors.methodChannel,
        (methodCall) async {
          log.add(methodCall);
          switch (methodCall.method) {
            case 'getPlatformName':
              return kPlatformName;
            default:
              return null;
          }
        },
      );
    });

    tearDown(log.clear);

    test('getPlatformName', () async {
      final platformName = await channelsFlutterSensors.getPlatformName();
      expect(
        log,
        <Matcher>[isMethodCall('getPlatformName', arguments: null)],
      );
      expect(platformName, equals(kPlatformName));
    });
  });
}
