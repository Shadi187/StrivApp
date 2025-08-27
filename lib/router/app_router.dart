// lib/router/app_router.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';

import '../Features/login/view/login_page.dart';
import '../Features/login/viewmodel/login_notifier.dart';
import '../Features/login/viewmodel/login_state.dart';
// import '../Features/home/view/home_shell.dart';

class StreamListenable extends ChangeNotifier {
  StreamListenable(Stream<dynamic> stream) {
    _subscription = stream.listen((_) => notifyListeners());
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(path: '/login', builder: (_, __) => const LoginPage()),
      GoRoute(path: '/', builder: (context, state) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Welcome to Strive App!', 
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => context.go('/login'),
                child: const Text('Back to Login'),
              ),
            ],
          ),
        ),
      )),
    ],
    redirect: (context, state) {
      final authState = ref.read(authNotifierProvider);
      
      // Add debug logging
      print('🔄 Router redirect - Current state: ${authState.runtimeType}');
      print('🔄 Current location: ${state.matchedLocation}');
      
      final isLoggedIn = authState is AuthAuthenticated;
      final isLoggingIn = state.matchedLocation == '/login';

      // If not logged in and not on login page, redirect to login
      if (!isLoggedIn && !isLoggingIn) {
        print('🔄 Redirecting to login');
        return '/login';
      }
      
      // If logged in and on login page, redirect to home
      if (isLoggedIn && isLoggingIn) {
        print('🔄 Redirecting to home');
        return '/';
      }
      
      // Otherwise, stay where you are
      print('🔄 Staying on current page');
      return null;
    },
    refreshListenable: StreamListenable(
      FirebaseAuth.instance.authStateChanges(),
    ),
  );
});