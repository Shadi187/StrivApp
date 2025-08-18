import 'package:flutter/material.dart';
import 'resetpassword.dart';
import 'widgets.dart'; //  Import for the reusable widgets

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final backgroundColor = const Color(0xFF0A0F2C);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppBackButton(onPressed: () => Navigator.pop(context)),

                const SizedBox(height: 20),
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
                const InputField(hint: "Email"),
                const SizedBox(height: 15),
                const InputField(hint: "Password", isPassword: true),

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

                PrimaryButton(label: "Sign in", onPressed: () {}),

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
