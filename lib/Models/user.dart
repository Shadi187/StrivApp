import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String email;
  final String firstName;
  final String lastName;
  final DateTime dateOfBirth;
  final String gender;
  final double heightCm;
  final double weightKg;
  final String profilePictureUrl;
  final DateTime createdAt;
  final DateTime lastLogin;
  final String fitnessLevel;
  final List<String> healthGoals;

  UserModel({
    required this.uid,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.gender,
    required this.heightCm,
    required this.weightKg,
    required this.profilePictureUrl,
    required this.createdAt,
    required this.lastLogin,
    required this.fitnessLevel,
    required this.healthGoals,
  });

  /// Factory constructor to create a UserModel instance from a map (e.g., from Firestore).
  factory UserModel.fromMap(String uid, Map<String, dynamic> data) {
    return UserModel(
      uid: uid,
      email: data['email'] ?? '',
      firstName: data['firstName'] ?? '',
      lastName: data['lastName'] ?? '',
      dateOfBirth: (data['dateOfBirth'] as Timestamp).toDate(),
      gender: data['gender'] ?? '',
      // Ensure heightCm is treated as a double
      heightCm: (data['heightCm'] as num?)?.toDouble() ?? 0.0,
      // Ensure weightKg is treated as a double
      weightKg: (data['weightKg'] as num?)?.toDouble() ?? 0.0,
      profilePictureUrl: data['profilePictureUrl'] ?? '',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      lastLogin: (data['lastLogin'] as Timestamp).toDate(),
      fitnessLevel: data['fitnessLevel'] ?? '',
      // Convert a list of dynamic to a list of strings
      healthGoals: List<String>.from(data['healthGoals'] ?? []),
    );
  }

  /// Converts the UserModel instance to a map for storing in Firestore.
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'dateOfBirth': Timestamp.fromDate(dateOfBirth),
      'gender': gender,
      'heightCm': heightCm,
      'weightKg': weightKg,
      'profilePictureUrl': profilePictureUrl,
      'createdAt': Timestamp.fromDate(createdAt),
      'lastLogin': Timestamp.fromDate(lastLogin),
      'fitnessLevel': fitnessLevel,
      'healthGoals': healthGoals,
    };
  }
}
