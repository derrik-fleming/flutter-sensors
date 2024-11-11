import CoreMotion
import Flutter
import UIKit

public class FlutterSensorsPlugin: NSObject, FlutterPlugin, FlutterStreamHandler {
    private var eventSink: FlutterEventSink?
    private let motionManager = CMMotionManager()

    public static func register(with registrar: FlutterPluginRegistrar) {
        let methodChannel = FlutterMethodChannel(name: "flutter_sensors_ios", binaryMessenger: registrar.messenger())
        let eventChannel = FlutterEventChannel(
            name: "flutter_sensors_ios/sensor_events",
            binaryMessenger: registrar.messenger()
        )
        let instance = FlutterSensorsPlugin()
        registrar.addMethodCallDelegate(instance, channel: methodChannel)
        eventChannel.setStreamHandler(instance)
    }

    public func handle(_: FlutterMethodCall, result: @escaping FlutterResult) {
        result("iOS")
    }

    public func onListen(withArguments _: Any?, eventSink: @escaping FlutterEventSink) -> FlutterError? {
        self.eventSink = eventSink
        startGyroscope()
        return nil
    }

    public func onCancel(withArguments _: Any?) -> FlutterError? {
        stopGyroscope()
        eventSink = nil
        return nil
    }

    private func startGyroscope() {
        if motionManager.isGyroAvailable {
            motionManager.gyroUpdateInterval = 0.1
            motionManager.startGyroUpdates(to: .main) { [weak self] data, _ in
                if let data = data {
                    self?.sendSensorData(
                        type: "gyro",
                        xValue: data.rotationRate.x,
                        yValue: data.rotationRate.y,
                        zValue: data.rotationRate.z
                    )
                }
            }
        }
    }

    private func stopGyroscope() {
        motionManager.stopGyroUpdates()
    }

    private func sendSensorData(type: String, xValue: Double, yValue: Double, zValue: Double) {
        let sensorData: [String: Any] = ["type": type, "x": xValue, "y": yValue, "z": zValue]
        if let jsonData = try? JSONSerialization.data(withJSONObject: sensorData),
           let jsonString = String(data: jsonData, encoding: .utf8)
        {
            eventSink?(jsonString)
        }
    }
}
