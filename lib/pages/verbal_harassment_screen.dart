import 'package:flutter/material.dart';

class VerbalHarassmentScreen extends StatelessWidget {
  const VerbalHarassmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        // The screenshot shows a standard thin back arrow
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Verbal Harassment',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700, // Matching the bold header in the image
            fontSize: 22,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const Spacer(flex: 1),
              
              // Illustration from the provided image
              Center(
                child: Image.asset(
                  'assets/verbal_harassment.png',
                  height: 260, // Sized to match visual proportion
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(Icons.forum_outlined, size: 80, color: Colors.blueAccent),
                    );
                  },
                ),
              ),
              
              const SizedBox(height: 40),
              
              // Descriptive Text from the source image
              const Text(
                'Verbal harassment involves using abusive language, yelling, insulting, humiliating, or offensive language that causes emotional distress or creates an uncomfortable work environment.',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 19,
                  height: 1.3, // Matching the line spacing in the UI
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              
              const Spacer(flex: 3),
              
              // Continue Button matches the grey/muted style
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      // Action to move forward
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFCCCCCC), // Light grey matching image
                      foregroundColor: Colors.white,
                      elevation: 4, // Subtle shadow as seen in the screenshot
                      shadowColor: Colors.black12,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20), // Bubbly corners
                      ),
                    ),
                    child: const Text(
                      'Continue',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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