import 'package:equatable/equatable.dart';
import '../../../Models/user.dart';

/*
 * STATE FILE EXPLANATION:
 * 
 * This file defines all possible states that our authentication feature can be in.
 * Think of states as "snapshots" of what's happening in your app at any moment.
 * 
 * WHY USE STATES?
 * - They represent different UI conditions (loading, success, error, etc.)
 * - They help the UI know what to display (spinner, content, error message)
 * - They make your app predictable and easier to debug
 * 
 * PATTERN TO FOLLOW FOR OTHER FEATURES:
 * 1. Create a sealed base class (prevents creating states outside this file)
 * 2. Extend Equatable (helps with state comparison and rebuilds)
 * 3. Create specific states for each condition your feature can have
 * 4. Always include relevant data in each state (like user data, error messages)
 */

// Base class for all authentication states
// 'sealed' means you can only create AuthState subclasses in this same file
// This prevents accidentally creating new states elsewhere in your code
sealed class AuthState extends Equatable {
  const AuthState();
  
  // Equatable helps Flutter know when to rebuild widgets
  // It compares states to see if they're actually different
  @override
  List<Object?> get props => [];
}

// INITIAL STATE: When the app first starts
// Use this when you don't know the auth status yet
class AuthInitial extends AuthState {
  const AuthInitial();
}

// LOADING STATE: When an auth operation is in progress
// Show a spinner or loading indicator when this state is active
// Examples: signing in, signing out, checking auth status
class AuthLoading extends AuthState {
  const AuthLoading();
}

// SUCCESS STATE: User is logged in and we have their data
// This state contains the actual user data that the UI can display
class AuthAuthenticated extends AuthState {
  final UserModel user; // The actual user data
  
  const AuthAuthenticated(this.user);
  
  // Include user in props so Equatable can compare different users
  @override
  List<Object?> get props => [user];
}

// LOGGED OUT STATE: User is not authenticated
// Show login screen when this state is active
class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated();
}

// ERROR STATE: Something went wrong
// Display error messages to the user when this state is active
class AuthError extends AuthState {
  final String message; // The error message to show
  
  const AuthError(this.message);
  
  // Include message in props for proper state comparison
  @override
  List<Object?> get props => [message];
}

/*
 * HOW TO CREATE STATES FOR OTHER FEATURES:
 * 
 * Example for a "Profile" feature:
 * 
 * sealed class ProfileState extends Equatable {
 *   const ProfileState();
 *   @override
 *   List<Object?> get props => [];
 * }
 * 
 * class ProfileInitial extends ProfileState {}
 * class ProfileLoading extends ProfileState {}
 * class ProfileLoaded extends ProfileState {
 *   final UserProfile profile;
 *   const ProfileLoaded(this.profile);
 *   @override
 *   List<Object?> get props => [profile];
 * }
 * class ProfileError extends ProfileState {
 *   final String message;
 *   const ProfileError(this.message);
 *   @override
 *   List<Object?> get props => [message];
 * }
 */