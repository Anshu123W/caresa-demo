import 'package:firstproduction_pro/backend/backend.dart';
import 'package:flutter/material.dart';
import '../widgets/option_tile.dart';
import '../widgets/continue_button.dart';

class StressSourcesScreen extends StatefulWidget {
  final int questionid_9;
  const StressSourcesScreen({super.key,required this.questionid_9});

  @override
  State<StressSourcesScreen> createState() => _StressSourcesScreenState();
}

class _StressSourcesScreenState extends State<StressSourcesScreen> {
  
  final List<String> options = [
    "Workload",
    "Academics",
    "Health",
    "Financial Concerns",
    "Feeling Disconnected",
    "Relationships (Personal/Professional)",
    "Work-Life Balance", // Added to broaden scope
    "Uncertainty about the future",
  ];

  final List<String> selected = [];

  void onSelect(String value) {
    setState(() {
      if (selected.contains(value)) {
        selected.remove(value);
      } else {
        if (selected.length < 3) {
          selected.add(value);
        } else {
          // Visual feedback if they try to select a 4th
          _showLimitReachedFeedback();
        }
      }
    });
  }

  void _showLimitReachedFeedback() {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("You can only select 3 sources."),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: Colors.black87,
        duration: const Duration(seconds: 1),
      ),
    );
  }
  void _handleContinue() async {
  if (selected.length != 3) return; // safety check

  // Map selected strings to backend IDs if needed
  final List<int> answerIds = selected.map((s) {
    switch (s) {
      case "Workload": return 1;
      case "Academics": return 2;
      case "Health": return 3;
      case "Financial Concerns": return 4;
      case "Feeling Disconnected": return 5;
      case "Relationships (Personal/Professional)": return 6;
      case "Work-Life Balance": return 7;
      case "Uncertainty about the future": return 8;
      default: return 0;
    }
  }).toList();

  final success = await sendresponse(
   
    questionIds: [widget.questionid_9], 
    answers: [answerIds],
  );

  if (success) {
    Navigator.pushNamed(context, '/stresslocation'); 
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Failed to save response!')),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    // Ensuring exactly 3 for progress
    final bool canContinue = selected.length == 3;
    final int remaining = 3 - selected.length;

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
          "Step 9 of 16",
          style: TextStyle(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                "What are your biggest sources of stress right now?",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A1A),
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 12),
              
              // Dynamic status text
              Row(
                children: [
                  Text(
                    canContinue 
                      ? "Perfect. Let's move on." 
                      : "Select $remaining more ${remaining == 1 ? 'option' : 'options'}",
                    style: TextStyle(
                      color: canContinue ? Colors.green.shade700 : Colors.grey.shade500,
                      fontSize: 15,
                      fontWeight: canContinue ? FontWeight.bold : FontWeight.w500,
                    ),
                  ),
                  if (canContinue) const Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Icon(Icons.check_circle, color: Colors.green, size: 18),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: options.length,
                  itemBuilder: (context, index) {
                    final option = options[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: OptionTile(
                        title: option,
                        isSelected: selected.contains(option),
                        onTap: () => onSelect(option),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 16),
              ContinueButton(
                onTap: canContinue
                ? () {
                  _handleContinue();
                }
                : () {}
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
