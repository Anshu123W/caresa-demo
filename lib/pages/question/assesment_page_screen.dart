import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../new_pages/normal_user_dashboard_page.dart';
import '../new_pages/organisation_user_dashboard_page.dart';
import '../../navigation/routes.dart';

class WellbeingAssessmentScreen extends StatelessWidget {
  const WellbeingAssessmentScreen({super.key});

  // Function to route to correct dashboard (used after final question)
  Future<void> _goToDashboard(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final userType = prefs.getString('userType');

    if (userType == 'organisation') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const OrganisationUserDashboardPage(),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const NormalUserDashboardPage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Step 1 of 16',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            const SizedBox(height: 20),

            const Text(
              'Let\'s map your\nwellbeing landscape',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1A1A),
                height: 1.2,
              ),
            ),

            const SizedBox(height: 24),

            Text(
              'This short assessment helps us understand your unique patterns, strengths, and areas for support. All your answers are private and secure.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
                height: 1.6,
              ),
            ),

            const SizedBox(height: 40),

            _buildPrivacyCard(),

            const Spacer(),

            const Icon(
              Icons.psychology_outlined,
              size: 70,
              color: Colors.black87,
            ),
            const SizedBox(height: 16),
            const Text(
              "I'm Ready, Let's Begin",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 32),

            // Continue Button → FIRST QUESTION
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.m2mood);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'CONTINUE',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildPrivacyCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9F9),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.shield_outlined,
            color: Colors.blueGrey,
            size: 24,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Privacy & Security',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Your organization only sees aggregated, anonymous insights to improve workplace culture.',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
