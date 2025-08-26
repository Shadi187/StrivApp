import 'package:cloud_firestore/cloud_firestore.dart';

class HealthGoalModel {
  final String userId;
  final String goalType;
  final double targetValue;
  final DateTime startDate;
  final DateTime targetDate;
  final bool isAchieved;
  final double progressPercentage;
  final Map<String, double> dailyProgress;

  HealthGoalModel({
    required this.userId,
    required this.goalType,
    required this.targetValue,
    required this.startDate,
    required this.targetDate,
    required this.isAchieved,
    required this.progressPercentage,
    required this.dailyProgress,
  });

  /// Factory constructor to create a HealthGoalModel instance from a map (e.g., from Firestore).
  factory HealthGoalModel.fromMap(Map<String, dynamic> data) {
    return HealthGoalModel(
      userId: data['userId'] ?? '',
      goalType: data['goalType'] ?? '',
      // Ensure numeric types are handled as doubles
      targetValue: (data['targetValue'] as num?)?.toDouble() ?? 0.0,
      startDate: (data['startDate'] as Timestamp).toDate(),
      targetDate: (data['targetDate'] as Timestamp).toDate(),
      isAchieved: data['isAchieved'] ?? false,
      progressPercentage:
          (data['progressPercentage'] as num?)?.toDouble() ?? 0.0,
      // Cast the map from dynamic values to double values
      dailyProgress: Map<String, double>.from(data['dailyProgress'] ?? {}),
    );
  }

  /// Converts the HealthGoalModel instance to a map for storing in Firestore.
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'goalType': goalType,
      'targetValue': targetValue,
      'startDate': Timestamp.fromDate(startDate),
      'targetDate': Timestamp.fromDate(targetDate),
      'isAchieved': isAchieved,
      'progressPercentage': progressPercentage,
      'dailyProgress': dailyProgress,
    };
  }

  /// Creates a copy of this HealthGoalModel but with the given fields replaced with the new values.
  HealthGoalModel copyWith({
    String? userId,
    String? goalType,
    double? targetValue,
    DateTime? startDate,
    DateTime? targetDate,
    bool? isAchieved,
    double? progressPercentage,
    Map<String, double>? dailyProgress,
  }) {
    return HealthGoalModel(
      userId: userId ?? this.userId,
      goalType: goalType ?? this.goalType,
      targetValue: targetValue ?? this.targetValue,
      startDate: startDate ?? this.startDate,
      targetDate: targetDate ?? this.targetDate,
      isAchieved: isAchieved ?? this.isAchieved,
      progressPercentage: progressPercentage ?? this.progressPercentage,
      dailyProgress: dailyProgress ?? this.dailyProgress,
    );
  }
}
