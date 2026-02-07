import 'package:firstproduction_pro/backend/backend.dart';
import 'package:flutter/material.dart';
import '../widgets/option_tile.dart';
import '../widgets/continue_button.dart';

class StressChallengesScreen extends StatefulWidget {
  final int questionid_11;
  const StressChallengesScreen({super.key,required this.questionid_11});

  @override
  State<StressChallengesScreen> createState() => _StressChallengesScreenState();
}

class _StressChallengesScreenState extends State<StressChallengesScreen> {
  final List<String> options = [
    "Nothing, I’m ready",
    "Not sure what to do",
    "Forgetting to open it",
    "Lack of time",
  ];

  final List<String> selected = [];

  void onSelect(String value) {
    setState(() {
      if (selected.contains(value)) {
        selected.remove(value);
      } else if (selected.length < 3) {
        selected.add(value);
      }
    });
  }
   List<int> _mapSelectedToIds() {
    return selected.map((s) {
      switch (s) {
        case "Nothing, I’m ready":
          return 1;
        case "Not sure what to do":
          return 2;
        case "Forgetting to open it":
          return 3;
        case "Lack of time":
          return 4;
        default:
          return 0;
      }
    }).toList();
  }
  void _handleContinue() async {
    if (selected.length != 3) return; // safety check

    final answerIds = _mapSelectedToIds();

    final success = await sendresponse(
     
      questionIds: [widget.questionid_11],
      answers: [answerIds],
    );

    if (success) {
      Navigator.pushNamed(context,'/learningPreference'); // replace with your next route
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to save response!')),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    // Logic to match the design requirements
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
          "Step 11 of 16",
          style: TextStyle(
            color: Colors.grey, 
            fontSize: 14, 
            fontWeight: FontWeight.w600,
          ),
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
                "What might make it challenging to use a wellbeing app regularly?",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A1A),
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 12),
              
              // Helper text that updates based on selection count
              Text(
                canContinue 
                  ? "Got it! Tap continue to proceed." 
                  : "Select $remaining more ${remaining == 1 ? 'option' : 'options'}.",
                style: TextStyle(
                  color: canContinue ? Colors.green.shade700 : Colors.grey.shade500,
                  fontSize: 15,
                  fontWeight: canContinue ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              const SizedBox(height: 32),

              Expanded(
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemCount: options.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final item = options[index];
                    return OptionTile(
                      title: item,
                      isSelected: selected.contains(item),
                      onTap: () => onSelect(item),
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