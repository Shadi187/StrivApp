import 'package:cloud_firestore/cloud_firestore.dart';

class DeviceModel {
  final String id;
  final String userId;
  final String deviceName;
  final String macAddress;
  final String firmwareVersion;
  final int batteryLevel;
  final DateTime lastSyncTimestamp;
  final bool isActive;

  DeviceModel({
    required this.id,
    required this.userId,
    required this.deviceName,
    required this.macAddress,
    required this.firmwareVersion,
    required this.batteryLevel,
    required this.lastSyncTimestamp,
    required this.isActive,
  });

  /// Factory constructor to create a DeviceModel instance from a map (e.g., from Firestore).
  factory DeviceModel.fromMap(String id, Map<String, dynamic> data) {
    return DeviceModel(
      id: id,
      userId: data['userId'] ?? '',
      deviceName: data['deviceName'] ?? '',
      macAddress: data['macAddress'] ?? '',
      firmwareVersion: data['firmwareVersion'] ?? '',
      batteryLevel: data['batteryLevel'] ?? 0,
      lastSyncTimestamp: (data['lastSyncTimestamp'] as Timestamp).toDate(),
      isActive: data['isActive'] ?? false,
    );
  }

  /// Converts the DeviceModel instance to a map for storing in Firestore.
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'deviceName': deviceName,
      'macAddress': macAddress,
      'firmwareVersion': firmwareVersion,
      'batteryLevel': batteryLevel,
      'lastSyncTimestamp': Timestamp.fromDate(lastSyncTimestamp),
      'isActive': isActive,
    };
  }

  /// Creates a copy of this DeviceModel but with the given fields replaced with the new values.
  DeviceModel copyWith({
    String? id,
    String? userId,
    String? deviceName,
    String? macAddress,
    String? firmwareVersion,
    int? batteryLevel,
    DateTime? lastSyncTimestamp,
    bool? isActive,
  }) {
    return DeviceModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      deviceName: deviceName ?? this.deviceName,
      macAddress: macAddress ?? this.macAddress,
      firmwareVersion: firmwareVersion ?? this.firmwareVersion,
      batteryLevel: batteryLevel ?? this.batteryLevel,
      lastSyncTimestamp: lastSyncTimestamp ?? this.lastSyncTimestamp,
      isActive: isActive ?? this.isActive,
    );
  }
}
