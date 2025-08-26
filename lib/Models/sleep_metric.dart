import 'package:cloud_firestore/cloud_firestore.dart';

class SleepRecordModel {
  final String userId;
  final DateTime startTime;
  final DateTime endTime;
  final int durationMinutes;
  final int sleepQualityScore;
  final int deepSleepMinutes;
  final int lightSleepMinutes;
  final int remSleepMinutes;
  final int awakeMinutes;
  final String notes;

  SleepRecordModel({
    required this.userId,
    required this.startTime,
    required this.endTime,
    required this.durationMinutes,
    required this.sleepQualityScore,
    required this.deepSleepMinutes,
    required this.lightSleepMinutes,
    required this.remSleepMinutes,
    required this.awakeMinutes,
    required this.notes,
  });

  /// Factory constructor to create a SleepRecordModel instance from a map (e.g., from Firestore).
  factory SleepRecordModel.fromMap(Map<String, dynamic> data) {
    return SleepRecordModel(
      userId: data['userId'] ?? '',
      startTime: (data['startTime'] as Timestamp).toDate(),
      endTime: (data['endTime'] as Timestamp).toDate(),
      durationMinutes: data['durationMinutes'] ?? 0,
      sleepQualityScore: data['sleepQualityScore'] ?? 0,
      deepSleepMinutes: data['deepSleepMinutes'] ?? 0,
      lightSleepMinutes: data['lightSleepMinutes'] ?? 0,
      remSleepMinutes: data['remSleepMinutes'] ?? 0,
      awakeMinutes: data['awakeMinutes'] ?? 0,
      notes: data['notes'] ?? '',
    );
  }

  /// Converts the SleepRecordModel instance to a map for storing in Firestore.
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'startTime': Timestamp.fromDate(startTime),
      'endTime': Timestamp.fromDate(endTime),
      'durationMinutes': durationMinutes,
      'sleepQualityScore': sleepQualityScore,
      'deepSleepMinutes': deepSleepMinutes,
      'lightSleepMinutes': lightSleepMinutes,
      'remSleepMinutes': remSleepMinutes,
      'awakeMinutes': awakeMinutes,
      'notes': notes,
    };
  }

  /// Creates a copy of this SleepRecordModel but with the given fields replaced with the new values.
  SleepRecordModel copyWith({
    String? userId,
    DateTime? startTime,
    DateTime? endTime,
    int? durationMinutes,
    int? sleepQualityScore,
    int? deepSleepMinutes,
    int? lightSleepMinutes,
    int? remSleepMinutes,
    int? awakeMinutes,
    String? notes,
  }) {
    return SleepRecordModel(
      userId: userId ?? this.userId,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      sleepQualityScore: sleepQualityScore ?? this.sleepQualityScore,
      deepSleepMinutes: deepSleepMinutes ?? this.deepSleepMinutes,
      lightSleepMinutes: lightSleepMinutes ?? this.lightSleepMinutes,
      remSleepMinutes: remSleepMinutes ?? this.remSleepMinutes,
      awakeMinutes: awakeMinutes ?? this.awakeMinutes,
      notes: notes ?? this.notes,
    );
  }
}
