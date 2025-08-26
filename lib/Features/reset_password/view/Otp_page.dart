import 'package:flutter/material.dart';
import '../../../Widgets/widgets.dart';

class EnterOTPPage extends StatefulWidget {
  final String email;

  const EnterOTPPage({super.key, required this.email});

  @override
  State<EnterOTPPage> createState() => _EnterOTPPageState();
}

class _EnterOTPPageState extends State<EnterOTPPage> {
  final int _otpLength = 6;
  late final List<TextEditingController> _controllers;
  late final List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(_otpLength, (_) => TextEditingController());
    _focusNodes = List.generate(_otpLength, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    for (final node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onOTPChanged(String value, int index) {
    if (value.isNotEmpty && index < _otpLength - 1) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
    setState(() {}); // refresh borders
  }

  void _verifyOTP() {
    final otp = _controllers.map((c) => c.text).join();
    print("Entered OTP: $otp");
    // TODO: Handle verification
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0F2C),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBackButton(onPressed: () => Navigator.pop(context)), 
              const SizedBox(height: 20),

              const Text(
                'Enter OTP',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'DroidSans',
                ),
              ),
              const SizedBox(height: 12),

              Text(
                "Please enter the OTP sent to your registered email: ${widget.email}",
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  fontFamily: 'DroidSans',
                ),
              ),

              const SizedBox(height: 40),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(_otpLength, (index) {
                  return Otp_page(
                    controller: _controllers[index],
                    focusNode: _focusNodes[index],
                    isFilled: _controllers[index].text.isNotEmpty,
                    onChanged: (value) => _onOTPChanged(value, index),
                  );
                }),
              ),

              const SizedBox(height: 40),

              PrimaryButton( 
                label: "Verify Code",
                onPressed: _verifyOTP,
              ),

              const SizedBox(height: 20),

              Center(
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'DroidSans',
                    ),
                    children: [
                      const TextSpan(text: "Didn't receive an OTP? "),
                      WidgetSpan(
                        child: GestureDetector(
                          onTap: () => print("Resend OTP tapped"),
                          child: const Text(
                            "Resend OTP",
                            style: TextStyle(
                              color: Color(0xFF1D72A0),
                              fontSize: 16,
                              decoration: TextDecoration.underline,
                              fontFamily: 'DroidSans',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
