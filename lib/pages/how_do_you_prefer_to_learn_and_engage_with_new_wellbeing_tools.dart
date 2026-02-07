import 'package:flutter/material.dart';

class HowDoYouPreferToLearnAndEngageWithNewWellbeingTools
    extends StatefulWidget {
  const HowDoYouPreferToLearnAndEngageWithNewWellbeingTools({Key? key})
      : super(key: key);

  @override
  State<HowDoYouPreferToLearnAndEngageWithNewWellbeingTools> createState() =>
      _HowDoYouPreferToLearnAndEngageWithNewWellbeingToolsState();
}

class _HowDoYouPreferToLearnAndEngageWithNewWellbeingToolsState
    extends State<HowDoYouPreferToLearnAndEngageWithNewWellbeingTools> {
  double sliderValue = 0.0;

  // ✅ FIXED STEP VALUES (THIS IS THE KEY)
  final int currentStep = 12;
  final int totalSteps = 16;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // ───────────── APP BAR ─────────────
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        centerTitle: true,
        title: Text(
          'Question $currentStep of $totalSteps',
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),

      // ───────────── BODY ─────────────
      body: Column(
        children: [
          // ✅ REAL, CORRECT PROGRESS BAR
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: LinearProgressIndicator(
              value: currentStep / totalSteps,
              minHeight: 4,
              backgroundColor: Colors.grey.shade300,
              valueColor:
                  const AlwaysStoppedAnimation<Color>(Colors.black),
            ),
          ),

          const SizedBox(height: 32),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'How do you prefer to learn and engage with new wellbeing tools?',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      height: 1.4,
                    ),
                  ),

                  const SizedBox(height: 48),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Guided',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Exploratory',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 6,
                      activeTrackColor: Colors.black,
                      inactiveTrackColor: Colors.grey.shade300,
                      thumbColor: Colors.black,
                      overlayShape: SliderComponentShape.noOverlay,
                    ),
                    child: Slider(
                      value: sliderValue,
                      min: 0,
                      max: 1,
                      divisions: 1,
                      onChanged: (value) {
                        setState(() {
                          sliderValue = value;
                        });
                      },
                    ),
                  ),

                  const Spacer(),

                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      onPressed: () {
                        // ✅ Navigate to NEXT screen
                        // Next screen will have:
                        // currentStep = 13
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        'CONTINUE',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 28),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
