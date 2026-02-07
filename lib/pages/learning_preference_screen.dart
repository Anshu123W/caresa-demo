import 'package:firstproduction_pro/backend/backend.dart';
import 'package:flutter/material.dart';
import '../widgets/continue_button.dart';
import '../navigation/routes.dart';

class LearningPreferenceScreen extends StatefulWidget {
  final int questionid_12;
  const LearningPreferenceScreen({super.key,required this.questionid_12});

  @override
  State<LearningPreferenceScreen> createState() => _LearningPreferenceScreenState();
}

class _LearningPreferenceScreenState extends State<LearningPreferenceScreen> {
  double sliderValue = 0.5;
  int _mapSliderToId() {
  if (sliderValue < 0.3) return 1; // Guided step-by-step
  if (sliderValue > 0.7) return 3; // Exploratory
  return 2; // Mixed
}

  // Dynamic feedback based on slider position
  String getPreferenceText() {
    if (sliderValue < 0.3) return "I want a step-by-step daily plan tailored for me.";
    if (sliderValue > 0.7) return "I prefer to browse and choose tools at my own pace.";
    return "I like a mix of guidance and personal freedom.";
  }
  void _handleContinue() async {
  final answerId = _mapSliderToId();

  final success = await sendresponse(
   
    questionIds: [widget.questionid_12],
    answers: [
      [answerId] // wrapped in list because `sendresponse` expects List<List<int>>
    ],
  );

  if (success) {
    Navigator.pushNamed(context, Routes.m4weekly);
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Failed to save response!')),
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
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          "Step 12 of 16",
          style: TextStyle(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              "How do you prefer to learn and engage with new wellbeing tools?",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1A1A),
                height: 1.3,
              ),
            ),
            const SizedBox(height: 60),

            // Preference Cards/Visuals
            Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F7),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  getPreferenceText(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 40),

            // Labels with icons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildModeLabel("Guided", Icons.ads_click),
                _buildModeLabel("Exploratory", Icons.explore_outlined),
              ],
            ),

            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: 6,
                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
                overlayShape: const RoundSliderOverlayShape(overlayRadius: 24),
              ),
              child: Slider(
                value: sliderValue,
                onChanged: (v) => setState(() => sliderValue = v),
                activeColor: Colors.black,
                inactiveColor: Colors.grey.shade200,
              ),
            ),

            const Spacer(),
            ContinueButton(
              onTap:_handleContinue,
               
              
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildModeLabel(String label, IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 20, color: Colors.grey.shade700),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}