import 'package:flutter/material.dart';

class PhysicalHarassmentScreen extends StatelessWidget {
  const PhysicalHarassmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        // Standard back arrow to match the UI navigation
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Physical Harassment',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700, // Bold header
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
                  'assets/physical_harassment.png', // Ensure this asset is in your pubspec.yaml
                  height: 260,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    // Fallback placeholder if image is missing
                    return Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(Icons.warning_amber_rounded, size: 80, color: Colors.redAccent),
                    );
                  },
                ),
              ),
              
              const SizedBox(height: 40),
              
              // Descriptive Text from the source image
              const Text(
                'Physical harassment includes unwanted physical contact such as touching, pushing, hitting, blocking movement, or any action that violates personal space or safety.',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 19,
                  height: 1.3,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              
              const Spacer(flex: 3),
              
              // Continue Button
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to the next section or logic
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFCCCCCC), // Muted grey button
                      foregroundColor: Colors.white,
                      elevation: 4,
                      shadowColor: Colors.black12,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
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