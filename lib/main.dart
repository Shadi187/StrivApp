import 'package:flutter/material.dart';
import 'package:strive_app/Otp_page.dart';
import 'package:strive_app/Features/reset_password/view/SetNewPasswordPage.dart';
import '../lib copy/login_page.dart';
import 'Features/register/view/register_page.dart';
import 'Features/reset_password/view/resetpassword.dart';
import 'Features/reset_password/view/SetNewPasswordPage.dart';
import 'Features/register/view/PersonalInfoPage.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'DroidSans',
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(), //
        '/register': (context) => RegisterPage(), //
        '/forget-password': (context) => ForgetPasswordPage(),
        '/SetPassword': (context) => SetNewPasswordPage(),
        '/Info': (context) => PersonalInfoPage(), //
        '/otp' : (context) => EnterOTPPage(email: '',),

      },
    );
  }
}
