import 'package:flutter/material.dart';

/// هنا Back Button
class AppBackButton extends StatelessWidget {
  final VoidCallback onPressed;
  const AppBackButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1D72A0),
        border: Border.all(color: const Color(0xFF1D72A0)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: const Icon(Icons.arrow_back, color: Colors.white),
      ),
    );
  }
}

/// هنا Input Field
class InputField extends StatelessWidget {
  final String hint;
  final bool isPassword;
  final TextEditingController controller;
  const InputField({super.key, required this.hint, this.isPassword = false, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isPassword,
      style: const TextStyle(
        fontFamily: 'DroidSans',
        color: Colors.white,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFF1B2238),
        hintText: hint,
        hintStyle: const TextStyle(
          fontFamily: 'DroidSans',
          color: Colors.white54,
        ),
        suffixIcon: isPassword
            ? const Icon(Icons.visibility_off, color: Colors.white54)
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

/// هنا Primary Button
class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  const PrimaryButton({super.key, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: Text(
          label,
          style: const TextStyle(fontFamily: 'DroidSans'),
        ),
      ),
    );
  }
}

/// هنا Social Buttons
class SocialButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  const SocialButton({super.key, required this.label, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.black),
      label: Text(
        label,
        style: const TextStyle(
          fontFamily: 'DroidSans',
          color: Colors.black,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}


/// OTP TextField Widget
class OTPField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final FocusNode? nextFocus;
  final FocusNode? prevFocus;

  const OTPField({
    super.key,
    required this.controller,
    required this.focusNode,
    this.nextFocus,
    this.prevFocus, required List<TextEditingController> allControllers,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
          fontFamily: 'DroidSans',
        ),
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: const Color(0xFF1B2238),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: controller.text.isNotEmpty
                  ? const Color(0xFF1D72A0)
                  : const Color(0xFF1D72A0),
            ),
          ),
        ),
        onChanged: (value) {
          if (value.isNotEmpty) {
            if (nextFocus != null) {
              FocusScope.of(context).requestFocus(nextFocus);
            } else {
              FocusScope.of(context).unfocus();
            }
          } else {
            if (prevFocus != null) {
              FocusScope.of(context).requestFocus(prevFocus);
            }
          }
        },
      ),
    );
  }
}

/// Success message section with icon
class SuccessMessage extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const SuccessMessage({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 120),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFF1D72A0),
          ),
          child: Icon(icon, size: 60, color: Colors.white),
        ),
        const SizedBox(height: 45),
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'DroidSans',
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          description,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: 'DroidSans',
            color: Color.fromARGB(219, 255, 255, 255),
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}

/// OTP TextField Widget

class Otp_page extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool isFilled;
  final ValueChanged<String> onChanged;

  const Otp_page({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.isFilled,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 60,
      decoration: BoxDecoration(
        color: const Color(0xFF1B2238),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: (focusNode.hasFocus || isFilled)
              ? const Color(0xFF1D72A0) // ✅ Correct border color
              : Colors.transparent,
          width: 2,
        ),
      ),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
          fontFamily: 'DroidSans',
        ),
        keyboardType: TextInputType.number,
        maxLength: 1,
        cursorColor: Colors.white, // ✅ makes the caret white
        decoration: const InputDecoration(
          counterText: '',
          border: InputBorder.none,
        ),
        onChanged: onChanged,
      ),
    );
  }
}

