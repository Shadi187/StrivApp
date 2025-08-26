import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../Models/user.dart';
import '../../../services/Firebase_auth/firebase_auth_service.dart';
import 'login_state.dart';

/*
 * NOTIFIER FILE EXPLANATION:
 * 
 * This file contains the business logic that manages state changes.
 * The Notifier is like a "controller" that:
 * - Holds the current state
 * - Contains methods to change the state
 * - Handles business logic (API calls, data processing)
 * - Notifies the UI when state changes
 * 
 * HOW STATE + NOTIFIER WORK TOGETHER:
 * 1. Notifier starts with an initial state (AuthInitial)
 * 2. UI calls notifier methods (like signInWithEmail)
 * 3. Notifier updates the state (to AuthLoading, then AuthAuthenticated or AuthError)
 * 4. UI automatically rebuilds to show the new state
 * 
 * RIVERPOD CONCEPTS:
 * - StateNotifier: Manages a single piece of state and notifies listeners
 * - StateNotifierProvider: Provides the notifier to widgets
 * - Provider: Provides computed values based on other providers
 */

// StateNotifier<AuthState> means:
// - This class manages AuthState
// - When state changes, all listening widgets rebuild automatically
class AuthNotifier extends StateNotifier<AuthState> {
  // Dependencies injected through constructor (good for testing)
  final FirebaseAuthRepository _authRepository;

  // Constructor: Set initial state and start listening to auth changes
  AuthNotifier(this._authRepository) : super(const AuthInitial()) {
    // Listen to Firebase auth state changes (login/logout from other devices, etc.)
    _authRepository.user.listen(_onAuthStateChanged);
  }

  /*
   * AUTOMATIC STATE LISTENING:
   * This method runs whenever Firebase auth state changes
   * (user logs in/out, token expires, etc.)
   */
  void _onAuthStateChanged(User? firebaseUser) {
    if (firebaseUser != null) {
      // User is logged in - load their complete profile data
      _loadUserData(firebaseUser);
    } else {
      // User is logged out - update state accordingly
      state = const AuthUnauthenticated();
    }
  }

  /*
   * PRIVATE HELPER METHOD:
   * Loads complete user data from your database
   * This converts Firebase User to your app's UserModel
   */
  Future<void> _loadUserData(User firebaseUser) async {
    try {
      // Step 1: Show loading state
      state = const AuthLoading();
      
      // Step 2: Fetch user data from Firestore
      // TODO: Replace this with actual Firestore query
      // Example: final doc = await FirebaseFirestore.instance.collection('users').doc(firebaseUser.uid).get();
      
      // Step 3: Create UserModel with the data
      final userModel = UserModel(
        uid: firebaseUser.uid,
        email: firebaseUser.email ?? '',
        firstName: '', // TODO: Get from Firestore
        lastName: '', // TODO: Get from Firestore
        dateOfBirth: DateTime.now(), // TODO: Get from Firestore
        gender: '', // TODO: Get from Firestore
        heightCm: 0.0, // TODO: Get from Firestore
        weightKg: 0.0, // TODO: Get from Firestore
        profilePictureUrl: firebaseUser.photoURL ?? '',
        createdAt: firebaseUser.metadata.creationTime ?? DateTime.now(),
        lastLogin: firebaseUser.metadata.lastSignInTime ?? DateTime.now(),
        fitnessLevel: '', // TODO: Get from Firestore
        healthGoals: [], // TODO: Get from Firestore
      );
      
      // Step 4: Update state with success
      state = AuthAuthenticated(userModel);
    } catch (e) {
      // Step 4 (alternative): Update state with error
      state = AuthError('Failed to load user data: ${e.toString()}');
    }
  }

  /*
   * PUBLIC METHOD: Sign in with email and password
   * This is what your UI will call when user submits login form
   */
  Future<void> signInWithEmail(String email, String password) async {
    try {
      // Step 1: Show loading state (spinner in UI)
      state = const AuthLoading();
      
      // Step 2: Call Firebase to sign in
      await _authRepository.signInWithEmail(email, password);
      
      // Step 3: No need to update state here!
      // _onAuthStateChanged will be called automatically and handle the state update
    } catch (e) {
      // Step 3 (if error): Show error state
      state = AuthError('Login failed: ${e.toString()}');
    }
  }

  /*
   * PUBLIC METHOD: Sign out
   * This is what your UI will call when user clicks logout
   */
  Future<void> signOut() async {
    try {
      state = const AuthLoading();
      await _authRepository.signOut();
      // _onAuthStateChanged will handle state update automatically
    } catch (e) {
      state = AuthError('Sign out failed: ${e.toString()}');
    }
  }

  /*
   * UTILITY METHOD: Clear error state
   * Call this when user dismisses an error message
   */
  void clearError() {
    if (state is AuthError) {
      state = const AuthUnauthenticated();
    }
  }

  /*
   * GETTER METHODS: Easy access to common state information
   * These make it easier for UI to check state without casting
   */
  
  // Check if user is authenticated
  bool get isAuthenticated => state is AuthAuthenticated;

  // Get current user (null if not authenticated)
  UserModel? get currentUser {
    final currentState = state;
    return currentState is AuthAuthenticated ? currentState.user : null;
  }
}

/*
 * PROVIDERS: How Riverpod exposes your notifier to widgets
 * 
 * Think of providers as "global variables" that widgets can access
 * But they're smart - widgets only rebuild when the data they use changes
 */

// Main provider: Gives widgets access to the AuthNotifier
// StateNotifierProvider manages both the notifier AND its state
final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  // Create the repository dependency
  final authRepository = FirebaseAuthRepository(FirebaseAuth.instance);
  // Return a new AuthNotifier instance
  return AuthNotifier(authRepository);
});

// Convenience provider: Just gives the current user (or null)
// Widgets that only need user data can watch this instead of the full state
final currentUserProvider = Provider<UserModel?>((ref) {
  final authState = ref.watch(authNotifierProvider);
  return authState is AuthAuthenticated ? authState.user : null;
});

// Convenience provider: Just gives authentication status
// Widgets that only need to know if user is logged in can watch this
final isAuthenticatedProvider = Provider<bool>((ref) {
  final authState = ref.watch(authNotifierProvider);
  return authState is AuthAuthenticated;
});

/*
 * HOW TO USE IN WIDGETS:
 * 
 * class MyWidget extends ConsumerWidget {
 *   @override
 *   Widget build(BuildContext context, WidgetRef ref) {
 *     // Watch the full state (rebuilds on any state change)
 *     final authState = ref.watch(authNotifierProvider);
 *     
 *     // Or watch just what you need (more efficient)
 *     final user = ref.watch(currentUserProvider);
 *     final isLoggedIn = ref.watch(isAuthenticatedProvider);
 *     
 *     // Call notifier methods
 *     final authNotifier = ref.read(authNotifierProvider.notifier);
 *     
 *     return ElevatedButton(
 *       onPressed: () => authNotifier.signInWithEmail(email, password),
 *       child: Text('Login'),
 *     );
 *   }
 * }
 * 
 * PATTERN FOR OTHER FEATURES:
 * 
 * 1. Create [Feature]State file with all possible states
 * 2. Create [Feature]Notifier extending StateNotifier<[Feature]State>
 * 3. Add business logic methods to the notifier
 * 4. Create providers to expose the notifier to widgets
 * 5. Use ref.watch() to listen to state changes in widgets
 * 6. Use ref.read() to call notifier methods from widgets
 */