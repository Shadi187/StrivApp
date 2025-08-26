class DailyMetricsModel {
  final String userId;
  final String date; // Using String for date, e.g., "YYYY-MM-DD"
  final int avgHeartRate;
  final int minHeartRate;
  final int maxHeartRate;
  final double avgSpo2;
  final double minSpo2;
  final double avgTemperature;
  final int totalSteps;
  final int totalCaloriesBurned;
  final int activeMinutes;
  final int restingMinutes;
  final Map<String, int> heartRateZones;
  final Map<String, dynamic> sleepData;

  DailyMetricsModel({
    required this.userId,
    required this.date,
    required this.avgHeartRate,
    required this.minHeartRate,
    required this.maxHeartRate,
    required this.avgSpo2,
    required this.minSpo2,
    required this.avgTemperature,
    required this.totalSteps,
    required this.totalCaloriesBurned,
    required this.activeMinutes,
    required this.restingMinutes,
    required this.heartRateZones,
    required this.sleepData,
  });

  /// Factory constructor to create a DailyMetricsModel instance from a map (e.g., from Firestore).
  factory DailyMetricsModel.fromMap(Map<String, dynamic> data) {
    return DailyMetricsModel(
      userId: data['userId'] ?? '',
      date: data['date'] ?? '',
      avgHeartRate: data['avgHeartRate'] ?? 0,
      minHeartRate: data['minHeartRate'] ?? 0,
      maxHeartRate: data['maxHeartRate'] ?? 0,
      // Ensure numeric types are handled correctly as doubles
      avgSpo2: (data['avgSpo2'] as num?)?.toDouble() ?? 0.0,
      minSpo2: (data['minSpo2'] as num?)?.toDouble() ?? 0.0,
      avgTemperature: (data['avgTemperature'] as num?)?.toDouble() ?? 0.0,
      totalSteps: data['totalSteps'] ?? 0,
      totalCaloriesBurned: data['totalCaloriesBurned'] ?? 0,
      activeMinutes: data['activeMinutes'] ?? 0,
      restingMinutes: data['restingMinutes'] ?? 0,
      // Cast the map from dynamic values to int values
      heartRateZones: Map<String, int>.from(data['heartRateZones'] ?? {}),
      sleepData: Map<String, dynamic>.from(data['sleepData'] ?? {}),
    );
  }

  /// Converts the DailyMetricsModel instance to a map for storing in Firestore.
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'date': date,
      'avgHeartRate': avgHeartRate,
      'minHeartRate': minHeartRate,
      'maxHeartRate': maxHeartRate,
      'avgSpo2': avgSpo2,
      'minSpo2': minSpo2,
      'avgTemperature': avgTemperature,
      'totalSteps': totalSteps,
      'totalCaloriesBurned': totalCaloriesBurned,
      'activeMinutes': activeMinutes,
      'restingMinutes': restingMinutes,
      'heartRateZones': heartRateZones,
      'sleepData': sleepData,
    };
  }

  /// Creates a copy of this DailyMetricsModel but with the given fields replaced with the new values.
  DailyMetricsModel copyWith({
    String? userId,
    String? date,
    int? avgHeartRate,
    int? minHeartRate,
    int? maxHeartRate,
    double? avgSpo2,
    double? minSpo2,
    double? avgTemperature,
    int? totalSteps,
    int? totalCaloriesBurned,
    int? activeMinutes,
    int? restingMinutes,
    Map<String, int>? heartRateZones,
    Map<String, dynamic>? sleepData,
  }) {
    return DailyMetricsModel(
      userId: userId ?? this.userId,
      date: date ?? this.date,
      avgHeartRate: avgHeartRate ?? this.avgHeartRate,
      minHeartRate: minHeartRate ?? this.minHeartRate,
      maxHeartRate: maxHeartRate ?? this.maxHeartRate,
      avgSpo2: avgSpo2 ?? this.avgSpo2,
      minSpo2: minSpo2 ?? this.minSpo2,
      avgTemperature: avgTemperature ?? this.avgTemperature,
      totalSteps: totalSteps ?? this.totalSteps,
      totalCaloriesBurned: totalCaloriesBurned ?? this.totalCaloriesBurned,
      activeMinutes: activeMinutes ?? this.activeMinutes,
      restingMinutes: restingMinutes ?? this.restingMinutes,
      heartRateZones: heartRateZones ?? this.heartRateZones,
      sleepData: sleepData ?? this.sleepData,
    );
  }
}
