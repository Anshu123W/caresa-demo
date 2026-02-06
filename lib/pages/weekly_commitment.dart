import 'package:flutter/material.dart';

class WeeklyCommitment extends StatefulWidget {
  const WeeklyCommitment({Key? key}) : super(key: key);

  @override
  State<WeeklyCommitment> createState() => _WeeklyCommitmentState();
}

class _WeeklyCommitmentState extends State<WeeklyCommitment> {
  String? selectedOption;

  final List<String> options = [
    'Just 5-10 minutes, a few times',
    '15-20 minutes, 2-3 times',
    "I'll play it by ear",
  ];

  Widget _optionTile(String text) {
    final bool isSelected = selectedOption == text;

    return GestureDetector(
      onTap: () => setState(() => selectedOption = text),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? Colors.black : Colors.grey.shade300,
            width: 1.5,
          ),
          boxShadow: isSelected 
            ? [BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 10, offset: const Offset(0, 4))] 
            : [],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  color: isSelected ? Colors.white : Colors.black87,
                ),
              ),
            ),
            // Checkmark feedback
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              child: Icon(
                isSelected ? Icons.check_circle_rounded : Icons.radio_button_off_rounded,
                color: isSelected ? Colors.white : Colors.grey.shade300,
                size: 22,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const BackButton(color: Colors.black),
        title: Column(
          children: [
            const Text(
              'Final Steps',
              style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 4),
            // Progress indicator (assuming this is near the end, e.g., 14 of 16)
            SizedBox(
              width: 80,
              height: 3,
              child: LinearProgressIndicator(
                value: 0.9, 
                backgroundColor: Colors.grey.shade200,
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.black),
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 32),
            const Text(
              "Set your pace",
              style: TextStyle(
                fontSize: 28, 
                fontWeight: FontWeight.bold,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              "What's a realistic amount of time you can dedicate to your wellbeing each week?",
              style: TextStyle(fontSize: 16, color: Colors.black54, height: 1.4),
            ),
            const SizedBox(height: 40),

            ...options.map(_optionTile),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 58,
              child: ElevatedButton(
                onPressed: selectedOption == null
                    ? null
                    : () {
                        // Navigate to Open Sharing screen
                        Navigator.pushNamed(context, '/m4opensharing');
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  disabledBackgroundColor: Colors.grey.shade300,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                  elevation: 0,
                ),
                child: const Text(
                  'CONTINUE',
                  style: TextStyle(
                    fontSize: 16, 
                    fontWeight: FontWeight.bold, 
                    color: Colors.white,
                    letterSpacing: 1.1,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}