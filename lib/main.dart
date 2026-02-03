import 'package:flutter/material.dart';
import '/pages/welcome_screen.dart';
import '../pages/signup_screen.dart';
import '../pages/set_password_screen.dart';
import '../pages/log_in_screen.dart';
import '../pages/reset_password_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Growth App',
      // The first screen that loads
      initialRoute: '/',

      routes: {
        '/': (context) => const WelcomeScreen(),
        '/personal': (context) => const SignUpScreen(),
        '/setPassword': (context) => const SetPasswordScreen(),
        '/login': (context) => const LoginScreen(),
        '/resetPassword': (context) => const ResetPasswordScreen(),
      },
    );
  }
}
