import 'package:flutter/material.dart';
import 'widgets.dart';

class ForgetPasswordPage extends StatelessWidget {
  const ForgetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0F2C),
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
                  'Forget Password',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'DroidSans',
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Please enter your Email to reset the password',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'DroidSans',
                  ),
                ),
                const SizedBox(height: 20),
                const InputField(hint: "Enter your email"),
                const SizedBox(height: 35),
                PrimaryButton(
                  label: "Reset Password",
                  onPressed: () {
                    Navigator.pushNamed(context, '/otp');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
