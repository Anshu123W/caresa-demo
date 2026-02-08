import 'package:flutter/material.dart';
import 'package:firstproduction_pro/navigation/routes.dart';

class ComplaintTrackingScreen extends StatefulWidget {
  const ComplaintTrackingScreen({super.key});

  @override
  State<ComplaintTrackingScreen> createState() =>
      _ComplaintTrackingScreenState();
}

class _ComplaintTrackingScreenState extends State<ComplaintTrackingScreen>
    with SingleTickerProviderStateMixin {
      
  // 0: Submitted, 1: Review, 2: Investigation, 3: Resolution
  int currentStep = 2;
  late AnimationController _rotationController;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  String _getMessage() {
    switch (currentStep) {
      case 0:
        return "System: Your complaint has been successfully submitted to the internal committee.";
      case 1:
        return "IC Coordinator: Your report has been received. Our team is reviewing the details.";
      case 2:
        return "System Update: \"Investigation phase initiated. An IC member will contact you shortly if additional witnesses are required. Status: Active";
      case 3:
        return "Final Update: The resolution has been reached. Please check your email for the detailed report.";
      default:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back, color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Complaint Tracking',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const Text(
              'Case ID: POSH-2026-1234',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 40),

            // Stepper Logic
            _buildStep(0, Icons.check_circle, "Report Submitted"),
            _buildStep(1, Icons.access_time, "Under Review by IC"),
            _buildStep(2, Icons.wb_sunny_outlined, "Investigation In Progress"),
            _buildStep(
              3,
              Icons.circle_outlined,
              "Resolution & Outcome",
              isLast: true,
            ),

            const SizedBox(height: 40),
            const Text(
              'Messages & Updates',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Dynamic Message Bubble
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black54),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                _getMessage(),
                style: const TextStyle(fontSize: 14, height: 1.4),
              ),
            ),
            const Spacer(),

            // Button to simulate progress
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (currentStep < 3) currentStep++;
                  });
                  Navigator.pushNamed(context, Routes.help1);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: currentStep == 3
                      ? Colors.black
                      : Colors.grey[300],
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  currentStep == 3 ? 'Finish' : 'Continue',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildStep(
    int stepIndex,
    IconData icon,
    String title, {
    bool isLast = false,
  }) {
    bool isCompleted = stepIndex < currentStep;
    bool isActive = stepIndex == currentStep;
    Color color = (isCompleted || isActive)
        ? Colors.black
        : Colors.grey.shade300;

    return IntrinsicHeight(
      child: Row(
        children: [
          Column(
            children: [
              // Rotating Icon for the active "Investigation" step
              (isActive && stepIndex == 2)
                  ? RotationTransition(
                      turns: _rotationController,
                      child: Icon(icon, size: 28, color: color),
                    )
                  : Icon(
                      isCompleted ? Icons.check_circle : icon,
                      size: 28,
                      color: color,
                    ),
              if (!isLast) Expanded(child: Container(width: 2.5, color: color)),
            ],
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                    color: color,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 35),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
