import 'package:flutter/material.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  int _currentStage = 0;

  final List<Map<String, String>> _loadingStages = [
    {
      'title': 'Crafting your space...',
      'subtitle': 'Personalizing your experience...',
    },
    {
      'title': 'Crafting your space...',
      'subtitle': 'Setting up your wellbeing journey...',
    },
    {
      'title': 'Crafting your space...',
      'subtitle': 'Preparing insights based on your goals...',
    },
  ];

  void _nextStage() {
    if (_currentStage < _loadingStages.length - 1) {
      setState(() {
        _currentStage++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque, 
        onTap: _nextStage,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Text(
                _loadingStages[_currentStage]['title']!,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 24),

    
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: index <= _currentStage
                          ? Colors.black
                          : Colors.grey.shade300,
                    ),
                  );
                }),
              ),

              const SizedBox(height: 16),

              Text(
                _loadingStages[_currentStage]['subtitle']!,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
