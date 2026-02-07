import 'package:flutter/material.dart';
import '../navigation/routes.dart'; // Import your route constants
import 'Prog_bar_primary_goals.dart';
import 'Goals_primary_goals.dart';
class TopBar extends StatefulWidget {
  const TopBar({super.key});

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  final Set<String> selectedGoals = {};
  final int maxSelections = 3;

  // Shared goal data
  final List<Map<String, dynamic>> goals = [
    {'icon': Icons.psychology_outlined, 'text': 'Reduce\nAnxiety', 'key': 'Reduce Anxiety'},
    {'icon': Icons.nightlight_outlined, 'text': 'Better\nSleep', 'key': 'Better Sleep'},
    {'icon': Icons.center_focus_weak_outlined, 'text': 'Improve\nFocus', 'key': 'Improve Focus'},
    {'icon': Icons.self_improvement_outlined, 'text': 'Manage\nStress', 'key': 'Manage Stress'},
    {'icon': Icons.spa_outlined, 'text': 'Mindful-\nness', 'key': 'Mindfulness'},
    {'icon': Icons.person_outline, 'text': 'Self-\nEsteem', 'key': 'Self-Esteem'},
    {'icon': Icons.work_outline, 'text': 'Work-Life Balance', 'key': 'Work-Life Balance'},
    {'icon': Icons.school_outlined, 'text': 'Academic Performance', 'key': 'Academic Performance'},
  ];

  void toggleGoal(String goal) {
    setState(() {
      if (selectedGoals.contains(goal)) {
        selectedGoals.remove(goal);
      } else if (selectedGoals.length < maxSelections) {
        selectedGoals.add(goal);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StepIndicator(currentStep: selectedGoals.length, totalSteps: maxSelections),
              const SizedBox(height: 24),
              
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios_new, size: 20),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  'Select your Primary Goals',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 8),
              const Center(
                child: Text(
                  'Select 3 options that apply to your day.',
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
              ),
              const SizedBox(height: 32),

              Expanded(
                child: GridView.builder(
                  itemCount: goals.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.1,
                  ),
                  itemBuilder: (context, index) {
                    final goal = goals[index];
                    return GoalTile(
                      icon: goal['icon'],
                      text: goal['text'],
                      isSelected: selectedGoals.contains(goal['key']),
                      onTap: () => toggleGoal(goal['key']),
                    );
                  },
                ),
              ),

              const SizedBox(height: 16),
              
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: selectedGoals.length == maxSelections
                      ? () => Navigator.pushNamed(context, Routes.loading)
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: Colors.grey.shade200,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    elevation: 0,
                  ),
                  child: const Text('Continue', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}