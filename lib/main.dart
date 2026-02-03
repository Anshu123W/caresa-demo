import 'package:firstproduction_pro/pages/Primary_goals.dart';
import 'package:firstproduction_pro/pages/crafting_space.dart';
import 'package:firstproduction_pro/pages/home_page_screen.dart';
import 'package:flutter/material.dart';
import './pages/welcome_screen.dart';
import './pages/signup_screen.dart';
import './pages/set_password_screen.dart';
import './pages/log_in_screen.dart';
import './pages/reset_password_screen.dart';
import './pages/company_verification_screen.dart';
import './pages/university_verification_screen.dart';
import './pages/uni_create_account_screen.dart';
import './pages/create_company_account_screen.dart';
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
        '/organization': (context) => const CompanyVerification(),
        '/university': (context) => const UniversityVerification(),
        '/uniSignUp': (context) => const UniCreateAccountScreen(),
        '/companySignUp': (context) => const CompanyCreateAccountScreen(),
        '/selectprimarygoals':(context)=>const TopBar(),
        '/craftingspace':(context)=>const LoadingPage(),
        '/homescreen':(context)=>const HomeScreen(),
      },
    );
  }
}
