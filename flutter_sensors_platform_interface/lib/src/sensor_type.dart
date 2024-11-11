/// Available sensor types
enum SensorType {
  /// The gyro sensor type
  gyro;

  @override
  String toString() => switch (this) { gyro => 'gyro' };

  /// Parses a [String] to a [SensorType]
  static SensorType parse(String value) => switch (value) {
        'gyro' => SensorType.gyro,
        _ => throw FormatException("Unknown SensorType: '$value'"),
      };
}
