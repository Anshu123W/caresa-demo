import 'package:flutter/material.dart';
import 'dart:async';

class M4ProcessingScreen extends StatefulWidget {
  const M4ProcessingScreen({Key? key}) : super(key: key);

  @override
  State<M4ProcessingScreen> createState() => _M4ProcessingScreenState();
}

class _M4ProcessingScreenState extends State<M4ProcessingScreen> {
  int _dotCount = 1;
  int _statusIndex = 0;
  double _progressValue = 0.0;
  late Timer _dotTimer;
  late Timer _progressTimer;

  final List<String> _statuses = [
    "Analyzing your patterns",
    "Personalizing your goals",
    "Curating mindfulness tools",
    "Finalizing your sanctuary"
  ];

  @override
  void initState() {
    super.initState();
    
    // Timer for the dots animation
    _dotTimer = Timer.periodic(const Duration(milliseconds: 500), (_) {
      setState(() {
        _dotCount = (_dotCount + 1) % 4;
      });
    });

    // Timer for progress bar and status text
    _progressTimer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      setState(() {
        if (_progressValue < 1.0) {
          _progressValue += 0.005; // Adjust speed here
          
          // Update status text based on progress thresholds
          if (_progressValue > 0.75) _statusIndex = 3;
          else if (_progressValue > 0.50) _statusIndex = 2;
          else if (_progressValue > 0.25) _statusIndex = 1;
        } else {
          _progressTimer.cancel();
          _navigateToHome();
        }
      });
    });
  }

  void _navigateToHome() {
    // Navigate to the final Dashboard or Congratulations screen
    Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
  }

  @override
  void dispose() {
    _dotTimer.cancel();
    _progressTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              
              // Animated Zen Image with a slight breathing scale effect
              TweenAnimationBuilder(
                tween: Tween<double>(begin: 0.95, end: 1.05),
                duration: const Duration(seconds: 2),
                curve: Curves.easeInOutSine,
                builder: (context, double scale, child) {
                  return Transform.scale(scale: scale, child: child);
                },
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100), // Circular looks more zen
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 30,
                        spreadRadius: 10,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(
                      'assets/images/zen.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 60),
              
              Text(
                'Personalizing Your\nSanctuary',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF2D2D2D),
                  height: 1.2,
                  letterSpacing: -0.5,
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Dynamic Status Text
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _statuses[_statusIndex],
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                    child: Text(
                      '.' * _dotCount,
                      style: TextStyle(
                        fontSize: 16, 
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 48),
              
              // Sleek Progress Bar
              Stack(
                children: [
                  Container(
                    height: 8,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  FractionallySizedBox(
                    widthFactor: _progressValue,
                    child: Container(
                      height: 8,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
              
              const Spacer(),
              
              Text(
                "Great things take a moment.",
                style: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}