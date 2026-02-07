import 'dart:async';
import 'package:flutter/material.dart';
import '../navigation/routes.dart';
import 'home_page_screen.dart';
import 'assesment_page_screen.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  int _currentStage = 0;
  Timer? _timer;

  final List<Map<String, String>> _loadingStages = [
    {
      'title': 'Crafting your space...',
      'subtitle': 'Personalizing your experience...',
    },
    {
      'title': 'Aligning your goals...',
      'subtitle': 'Setting up your wellbeing journey...',
    },
    {
      'title': 'Almost there...',
      'subtitle': 'Preparing insights based on your choices...',
    },
  ];

  @override
  void initState() {
    super.initState();
    _startLoadingSequence();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startLoadingSequence() {
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (_currentStage < _loadingStages.length - 1) {
        if (mounted) {
          setState(() => _currentStage++);
        }
      } else {
        _timer?.cancel();
        _navigateToAssessment();
      }
    });
  }

  void _navigateToAssessment() {
    // We use pushAndRemoveUntil so the user can't "Go Back" into the loading animation
    Navigator.of(context).pushAndRemoveUntil(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const WellbeingAssessmentScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 800),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Circular Progress Indicator for visual motion
            const SizedBox(
              height: 40,
              width: 40,
              child: CircularProgressIndicator(
                color: Colors.black,
                strokeWidth: 2,
              ),
            ),
            const SizedBox(height: 48),

            AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: Text(
                _loadingStages[_currentStage]['title']!,
                key: ValueKey('title_$_currentStage'),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Subtle Dots Indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: index == _currentStage ? 24 : 8,
                  height: 4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: index == _currentStage
                        ? Colors.black
                        : Colors.grey.shade200,
                  ),
                );
              }),
            ),

            const SizedBox(height: 24),

            AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: Text(
                _loadingStages[_currentStage]['subtitle']!,
                key: ValueKey('sub_$_currentStage'),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey.shade500,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
