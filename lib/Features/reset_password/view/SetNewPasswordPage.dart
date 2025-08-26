import 'package:flutter/material.dart';
import '../../../Features/reset_password/view/PasswordChangedSuccessPage.dart'; 
import '../../../Widgets/widgets.dart'; 

class SetNewPasswordPage extends StatelessWidget {
  const SetNewPasswordPage({super.key});

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
                  'Set a new Password',
                  style: TextStyle(
                    fontFamily: 'DroidSans',
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Create a new password. Ensure it differs from previous ones for security',
                  style: TextStyle(
                    fontFamily: 'DroidSans',
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 30),

                // const InputField(hint: "Enter new password", isPassword: true),
                const SizedBox(height: 15),
                // const InputField(hint: "Confirm password", isPassword: true),

                const SizedBox(height: 30),

                PrimaryButton(
                  label: "Change Password",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const PasswordChangedSuccessPage(),
                      ),
                    );
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
