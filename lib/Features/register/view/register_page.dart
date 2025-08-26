import 'package:flutter/material.dart';
import '../../../Features/login/view/login_page.dart';
import '../../../Widgets/widgets.dart'; 

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

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
                  "Hello! Register to get started",
                  style: TextStyle(
                    fontFamily: 'DroidSans',
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 30),
                const InputField(hint: "Username"),
                const SizedBox(height: 15),
                const InputField(hint: "Email"),
                const SizedBox(height: 15),
                const InputField(hint: "Password", isPassword: true),
                const SizedBox(height: 15),
                const InputField(hint: "Confirm password", isPassword: true),

                const SizedBox(height: 25),
                PrimaryButton(label: "Register", onPressed: () {}),

                const SizedBox(height: 20),
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

                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SocialButton(label: "Google", icon: Icons.email, onPressed: () {}),
                    SocialButton(label: "Facebook", icon: Icons.facebook, onPressed: () {}),
                  ],
                ),

                const SizedBox(height: 25),
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginPage()),
                      );
                    },
                    child: const Text.rich(
                      TextSpan(
                        text: "Already have an account? ",
                        style: TextStyle(
                          fontFamily: 'DroidSans',
                          color: Colors.white,
                        ),
                        children: [
                          TextSpan(
                            text: "Login Now",
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
