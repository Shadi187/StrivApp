import 'package:cloud_firestore/cloud_firestore.dart';

class HealthMetricModel {
  final String userId;
  final String deviceId;
  final DateTime timestamp;
  final int heartRate;
  final double spo2Percentage;
  final double temperatureCelsius;
  final double motionIntensity;
  final int stepsCount;
  final int caloriesBurned;

  HealthMetricModel({
    required this.userId,
    required this.deviceId,
    required this.timestamp,
    required this.heartRate,
    required this.spo2Percentage,
    required this.temperatureCelsius,
    required this.motionIntensity,
    required this.stepsCount,
    required this.caloriesBurned,
  });

  /// Factory constructor to create a HealthMetricModel instance from a map (e.g., from Firestore).
  factory HealthMetricModel.fromMap(Map<String, dynamic> data) {
    return HealthMetricModel(
      userId: data['userId'] ?? '',
      deviceId: data['deviceId'] ?? '',
      timestamp: (data['timestamp'] as Timestamp).toDate(),
      heartRate: data['heartRate'] ?? 0,
      // Ensure spo2Percentage is treated as a double
      spo2Percentage: (data['spo2Percentage'] as num?)?.toDouble() ?? 0.0,
      // Ensure temperatureCelsius is treated as a double
      temperatureCelsius:
          (data['temperatureCelsius'] as num?)?.toDouble() ?? 0.0,
      // Ensure motionIntensity is treated as a double
      motionIntensity: (data['motionIntensity'] as num?)?.toDouble() ?? 0.0,
      stepsCount: data['stepsCount'] ?? 0,
      caloriesBurned: data['caloriesBurned'] ?? 0,
    );
  }

  /// Converts the HealthMetricModel instance to a map for storing in Firestore.
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'deviceId': deviceId,
      'timestamp': Timestamp.fromDate(timestamp),
      'heartRate': heartRate,
      'spo2Percentage': spo2Percentage,
      'temperatureCelsius': temperatureCelsius,
      'motionIntensity': motionIntensity,
      'stepsCount': stepsCount,
      'caloriesBurned': caloriesBurned,
    };
  }

  /// Creates a copy of this HealthMetricModel but with the given fields replaced with the new values.
  HealthMetricModel copyWith({
    String? userId,
    String? deviceId,
    DateTime? timestamp,
    int? heartRate,
    double? spo2Percentage,
    double? temperatureCelsius,
    double? motionIntensity,
    int? stepsCount,
    int? caloriesBurned,
  }) {
    return HealthMetricModel(
      userId: userId ?? this.userId,
      deviceId: deviceId ?? this.deviceId,
      timestamp: timestamp ?? this.timestamp,
      heartRate: heartRate ?? this.heartRate,
      spo2Percentage: spo2Percentage ?? this.spo2Percentage,
      temperatureCelsius: temperatureCelsius ?? this.temperatureCelsius,
      motionIntensity: motionIntensity ?? this.motionIntensity,
      stepsCount: stepsCount ?? this.stepsCount,
      caloriesBurned: caloriesBurned ?? this.caloriesBurned,
    );
  }
}
