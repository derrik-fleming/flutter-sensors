import 'package:flutter/material.dart';
import 'package:flutter_sensors/flutter_sensors.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: SensorDataDisplay());
  }
}

class GyroSensorDataWidget extends StatelessWidget {
  const GyroSensorDataWidget({
    required GyroSensorData data,
    super.key,
  }) : _data = data;

  final GyroSensorData _data;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Sensor: Gyro Data',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        Text(
          'X: ${_data.x.toStringAsFixed(8)}',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        Text(
          'Y: ${_data.y.toStringAsFixed(8)}',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        Text(
          'Z: ${_data.z.toStringAsFixed(8)}',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}

class SensorDataDisplay extends StatelessWidget {
  const SensorDataDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('FlutterSensorsPlugin Example')),
      body: Center(
        child: StreamBuilder<SensorData>(
          stream: sensorData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            if (snapshot.hasError) {
              return Text(
                'Error: ${snapshot.error}',
                style: Theme.of(context).textTheme.headlineSmall,
              );
            }

            if (!snapshot.hasData) {
              return const Text('No sensor data available');
            }

            final data = snapshot.data!;

            return switch (data) {
              final GyroSensorData d => GyroSensorDataWidget(data: d),
              _ => const Text('Unknown data type'),
            };
          },
        ),
      ),
    );
  }
}
