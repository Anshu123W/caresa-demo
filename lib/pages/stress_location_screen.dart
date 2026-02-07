import 'package:firstproduction_pro/backend/backend.dart';
import 'package:flutter/material.dart';
import '../widgets/option_tile.dart';
import '../widgets/continue_button.dart';

class StressLocationScreen extends StatefulWidget {
  final int questionid_10;
  const StressLocationScreen({super.key, required this.questionid_10});

  @override
  State<StressLocationScreen> createState() => _StressLocationScreenState();
}

class _StressLocationScreenState extends State<StressLocationScreen> {
  final List<String> options = [
    "At my work / school",
    "In meetings or class",
    "During commute",
    "At home",
    "In social situations",
    "While trying to sleep",
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

  // Map selected locations to backend IDs
  List<int> _mapSelectedToIds() {
    return selected.map((s) {
      switch (s) {
        case "At my work / school":
          return 1;
        case "In meetings or class":
          return 2;
        case "During commute":
          return 3;
        case "At home":
          return 4;
        case "In social situations":
          return 5;
        case "While trying to sleep":
          return 6;
        default:
          return 0;
      }
    }).toList();
  }

  // Handle Continue button tap with DB call
  void _handleContinue() async {
    if (selected.length != 3) return; // safety check

    final answerIds = _mapSelectedToIds();

    final success = await sendresponse(
    
      questionIds: [widget.questionid_10],
      answers: [answerIds],
    );

    if (success) {
      Navigator.pushNamed(context, '/stresschallenge');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to save response!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
          "Step 10 of 16",
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
                "Where do you most often feel your stress?",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A1A),
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                canContinue 
                  ? "Got it! Tap continue to proceed." 
                  : "Select $remaining more ${remaining == 1 ? 'location' : 'locations'}.",
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
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
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
