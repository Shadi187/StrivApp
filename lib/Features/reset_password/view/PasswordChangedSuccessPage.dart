import 'package:flutter/material.dart';
import '../../../Features/login/view/login_page.dart';
import '../../../Widgets/widgets.dart';

class PasswordChangedSuccessPage extends StatelessWidget {
  const PasswordChangedSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0F2C),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              SuccessMessage(
                icon: Icons.check,
                title: 'Successful',
                description: 'Congratulations! Your password has been successfully updated.',
              ),
              const Spacer(),
              PrimaryButton(
                label: "Continue to Login",
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginPage()),
                    (route) => false,
                  );
                },
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}
