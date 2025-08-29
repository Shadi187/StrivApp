// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:strive_app/Features/login/viewmodel/login_notifier.dart';
// import 'package:strive_app/Features/login/viewmodel/login_state.dart';
// import 'package:strive_app/services/firebase_options.dart';
// import 'router/app_router.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
  
//   try {
//     // Initialize Firebase with proper options
//     await Firebase.initializeApp(
//       options: DefaultFirebaseOptions.currentPlatform,
//     );
//     print('✅ Firebase initialized successfully');
//   } catch (e) {
//     print('❌ Firebase initialization failed: $e');
//   }
  
//   runApp(const ProviderScope(child: App()));
// }

// class App extends ConsumerWidget {
//   const App({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final router = ref.watch(routerProvider);
//     final authState = ref.watch(authNotifierProvider);
    
//     // Show loading screen while Firebase is initializing
//     if (authState is AuthInitial || authState is AuthLoading) {
//       return MaterialApp(
//         home: Scaffold(
//           body: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: const [
//                 CircularProgressIndicator(),
//                 SizedBox(height: 16),
//                 Text('Loading...'),
//               ],
//             ),
//           ),
//         ),
//       );
//     }
    
//     return MaterialApp.router(
//       routerConfig: router,
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:strive_app/Features/login/viewmodel/login_notifier.dart';
import 'package:strive_app/Features/login/viewmodel/login_state.dart';
import 'package:strive_app/Features/login/view/login_page.dart';
import 'package:strive_app/services/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    // Initialize Firebase with proper options
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print('✅ Firebase initialized successfully');
  } catch (e) {
    print('❌ Firebase initialization failed: $e');
  }
  
  runApp(const ProviderScope(child: App()));
}

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);
    
    print('🔍 Current auth state: ${authState.runtimeType}');
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _buildHomeScreen(authState),
    );
  }
  
  Widget _buildHomeScreen(AuthState authState) {
    // Handle different auth states
    switch (authState) {
      case AuthInitial():
        return const Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('Initializing...'),
              ],
            ),
          ),
        );
        
      case AuthLoading():
        return const Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('Loading...'),
              ],
            ),
          ),
        );
        
      case AuthAuthenticated():
        return Scaffold(
          appBar: AppBar(
            title: const Text('Welcome to Strive App'),
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
          ),
          body: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.check_circle, color: Colors.green, size: 64),
                SizedBox(height: 16),
                Text(
                  'Successfully Logged In!',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text('Firebase authentication is working correctly.'),
              ],
            ),
          ),
        );
        
      case AuthUnauthenticated():
        return const LoginPage();
        
      case AuthError():
        final error = authState as AuthError;
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error, color: Colors.red, size: 64),
                const SizedBox(height: 16),
                const Text(
                  'Authentication Error',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  error.message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // Reset to initial state to retry
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        );
    }
  }
}