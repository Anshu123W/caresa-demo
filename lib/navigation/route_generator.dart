import 'package:flutter/material.dart';
import 'routes.dart';

// Pages - Authentication & Verification
import 'package:firstproduction_pro/pages/welcome_screen.dart';
import 'package:firstproduction_pro/pages/signup_screen.dart';
import 'package:firstproduction_pro/pages/set_password_screen.dart';
import 'package:firstproduction_pro/pages/log_in_screen.dart';
import 'package:firstproduction_pro/pages/reset_password_screen.dart';
import 'package:firstproduction_pro/pages/company_verification_screen.dart';
import 'package:firstproduction_pro/pages/university_verification_screen.dart';
import 'package:firstproduction_pro/pages/uni_create_account_screen.dart';
import 'package:firstproduction_pro/pages/create_company_account_screen.dart';

// Pages - Core App & Onboarding
import 'package:firstproduction_pro/pages/Primary_goals.dart';
import 'package:firstproduction_pro/pages/home_page_screen.dart';
import 'package:firstproduction_pro/pages/Crafting_space.dart';
import 'package:firstproduction_pro/pages/personalization_loading_screen.dart';

// Pages - Assessment Journey
import 'package:firstproduction_pro/pages/assesment_page_screen.dart';
import 'package:firstproduction_pro/pages/m2_current_energy_and_mood_screen.dart';
import 'package:firstproduction_pro/pages/reduce_anxiety_feelings_screen.dart';
import 'package:firstproduction_pro/pages/overwhelmed_actions_screen.dart';
import 'package:firstproduction_pro/pages/support_level_screen.dart';
import 'package:firstproduction_pro/pages/sleep_quality_screen.dart';
import 'package:firstproduction_pro/pages/physical_activity_screen.dart';
import 'package:firstproduction_pro/pages/stress_sources_screen.dart';
import 'package:firstproduction_pro/pages/stress_location_screen.dart';
import 'package:firstproduction_pro/pages/stress_challenges_screen.dart';
import 'package:firstproduction_pro/pages/learning_preference_screen.dart';
import 'package:firstproduction_pro/pages/open_reflection_screen.dart';
import 'package:firstproduction_pro/pages/do_you_currently_have_any_mindfulness_routines.dart';
import 'package:firstproduction_pro/pages/weekly_commitment.dart';

// Pages - Results & Analysis
import 'package:firstproduction_pro/pages/insights_review_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class RouteGenerator {
  RouteGenerator._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.welcome:
        return MaterialPageRoute(builder: (_) => const WelcomeScreen());
      case Routes.signup:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case Routes.setPassword:
        return MaterialPageRoute(builder: (_) => const SetPasswordScreen());
      case Routes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case Routes.resetPassword:
        return MaterialPageRoute(builder: (_) => const ResetPasswordScreen());

      // Verification Flow
      case Routes.companyVerification:
        return MaterialPageRoute(builder: (_) => const CompanyVerification());
      case Routes.universityVerification:
        return MaterialPageRoute(
          builder: (_) => const UniversityVerification(),
        );
      case Routes.uniSignUp:
        return MaterialPageRoute(
          builder: (_) => const UniCreateAccountScreen(),
        );
      case Routes.companySignUp:
        return MaterialPageRoute(
          builder: (_) => const CompanyCreateAccountScreen(),
        );

      // Main Navigation
      case Routes.primary:
        return MaterialPageRoute(builder: (_) => const TopBar());
      case Routes.loading:
        return MaterialPageRoute(builder: (_) => const LoadingPage());
      case Routes.home:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => const HomeScreen(),
          transitionsBuilder: (_, animation, __, child) =>
              FadeTransition(opacity: animation, child: child),
          transitionDuration: Duration(milliseconds: 500),
        );

      case Routes.assessment:
        return MaterialPageRoute(
          builder: (_) => WellbeingAssessmentScreen(),
        );

      case Routes.m2mood:
        return MaterialPageRoute(builder: (_) =>  MoodSelectionScreen(questionid_2: 2,));
      case Routes.m3primary:
        return MaterialPageRoute(
          builder: (_) => ReduceAnxietyFeelingsScreen(questionid_3: 3,),
        );
      case Routes.m4copping:
        return MaterialPageRoute(
          builder: (_) => OverwhelmedActionsScreen(questionid_4: 4,),
        );
      case Routes.m5support:
        return MaterialPageRoute(builder: (_) =>  SupportLevelScreen(questionid_5: 5,));

      case Routes.m2sleep:
        return MaterialPageRoute(builder: (_) =>SleepQualityScreen(questionid_6_1: 60,questionid_6_2:61,));

      case Routes.physicalActivity:
        return MaterialPageRoute(
          builder: (_) => const PhysicalActivityScreen(questionid_7: 7,),
        );

      case Routes.stress:
        return MaterialPageRoute(builder: (_) => StressSourcesScreen(questionid_9: 9,));

      case Routes.stresslocation:
        return MaterialPageRoute(builder: (_) => StressLocationScreen(questionid_10: 10,));

      // Ensure this matches the Step 12 Focus Area we built
      case Routes.stresschallenge:
        return MaterialPageRoute(
          builder: (_) => StressChallengesScreen(questionid_11: 11,),
        );

      case Routes.learningPreference:
        return MaterialPageRoute(
          builder: (_) =>  LearningPreferenceScreen(questionid_12: 12,),
        );

      case Routes.m4opensharing:
        return MaterialPageRoute(builder: (_) =>M4OpenSharingScreen(questionid_14:14));

      // THE FINAL SEQUENCE - Using a FadeTransition for a smoother "Processing" feel
      case Routes.m4processing:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => const M4ProcessingScreen(),
          transitionsBuilder: (_, animation, __, child) =>
              FadeTransition(opacity: animation, child: child),
          transitionDuration: const Duration(milliseconds: 800),
        );

      case Routes.insights:
        return MaterialPageRoute(builder: (_) => const M4InsightsScreen(questionid_15: 15,));

      case Routes.m2mindfulness:
        return MaterialPageRoute(
          builder: (_) => const MindfulnessRoutineScreen(questionid_8: 8,),
        );

      case Routes.m4weekly:
        return MaterialPageRoute(builder: (_) => const WeeklyCommitment(questionid_13: 13,));

      case Routes.home:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => const HomeScreen(),
          transitionsBuilder: (_, animation, __, child) =>
              FadeTransition(opacity: animation, child: child),
          transitionDuration: const Duration(milliseconds: 500),
        );

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) =>
          const Scaffold(body: Center(child: Text('Route not found'))),
    );
  }
}
