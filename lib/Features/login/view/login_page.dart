import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../Widgets/widgets.dart';
import '../../../Features/reset_password/view/resetpassword.dart';
import '../viewmodel/login_notifier.dart';
import '../viewmodel/login_state.dart';

// Change from StatelessWidget to ConsumerWidget to use Riverpod
class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final backgroundColor = const Color.fromRGBO(9, 13, 25, 1);
    
    // WATCH THE STATE - UI rebuilds when state changes
    final authState = ref.watch(authNotifierProvider);
    
    // Controllers for form fields
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60),
                const Text(
                  "Hello! Sign in to your account",
                  style: TextStyle(
                    fontFamily: 'DroidSans',
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 30),
                
                // Email field
                InputField(
                  hint: "Email",
                  controller: emailController,
                ),
                const SizedBox(height: 15),
                
                // Password field
                InputField(
                  hint: "Password", 
                  isPassword: true,
                  controller: passwordController,
                ),

                // Show error message if there's an error
                if (authState is AuthError) ...[
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.red.withOpacity(0.3)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.error, color: Colors.red, size: 20),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            authState.message,
                            style: const TextStyle(color: Colors.red, fontSize: 14),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            // READ THE NOTIFIER - call its methods
                            ref.read(authNotifierProvider.notifier).clearError();
                          },
                          icon: const Icon(Icons.close, color: Colors.red, size: 20),
                        ),
                      ],
                    ),
                  ),
                ],

                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => ForgetPasswordPage()),
                      );
                    },
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(
                        fontFamily: 'DroidSans',
                        color: Color.fromARGB(255, 168, 168, 168),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),

                // Login button - changes based on state
                PrimaryButton(
                  label: authState is AuthLoading ? "Signing in..." : "Sign in",
                  onPressed: authState is AuthLoading? null // Disable button when loading
                      : () {
                          // READ THE NOTIFIER - call signInWithEmail method
                          final notifier = ref.read(authNotifierProvider.notifier);
                          notifier.signInWithEmail(
                            emailController.text.trim(),
                            passwordController.text.trim(),
                          );
                        },
                ),

                // Show loading indicator if loading
                if (authState is AuthLoading) ...[
                  const SizedBox(height: 20),
                  const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFF1D72A0),
                    ),
                  ),
                ],

                const SizedBox(height: 40),
                const Row(
                  children: [
                    Expanded(child: Divider(color: Color(0xFF1D72A0))),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "Or login with",
                        style: TextStyle(
                          fontFamily: 'DroidSans',
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Expanded(child: Divider(color: Color(0xFF1D72A0))),
                  ],
                ),

                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SocialButton(label: "Google", icon: Icons.email, onPressed: () {}),
                    SocialButton(label: "Facebook", icon: Icons.facebook, onPressed: () {}),
                  ],
                ),

                const SizedBox(height: 40),
                Center(
                  child: TextButton(
                    onPressed: () {},
                    child: const Text.rich(
                      TextSpan(
                        text: "Don't have an account? ",
                        style: TextStyle(
                          fontFamily: 'DroidSans',
                          color: Colors.white,
                        ),
                        children: [
                          TextSpan(
                            text: "Sign Up",
                            style: TextStyle(
                              fontFamily: 'DroidSans',
                              color: Color(0xFF1D72A0),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
