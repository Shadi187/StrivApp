import 'package:flutter/material.dart';
import 'package:strive_app/Otp_page.dart';
import 'package:strive_app/SetNewPasswordPage.dart';
import 'login_page.dart';
import 'register_page.dart';
import 'resetpassword.dart';
import 'SetNewPasswordPage.dart';
import 'PersonalInfoPage.dart';
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
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/forget-password': (context) => ForgetPasswordPage(),
        '/SetPassword': (context) => SetNewPasswordPage(),
        '/Info': (context) => PersonalInfoPage(),
        '/otp' : (context) => EnterOTPPage(email: '',),

      },
    );
  }
}
