import 'package:flutter/material.dart';
import 'package:internshiptask1/Goals_primary_goals.dart';
import 'package:internshiptask1/Prog_bar_primary_goals.dart';
import 'package:internshiptask1/Crafting_space.dart';
class TopBar extends StatefulWidget {
  const TopBar({super.key});

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  final Set<String> selectedGoals = {};
  final int maxSelections = 3;


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
   
    final List<Map<String, dynamic>> firstSixGoals = [
      {'icon':Icons.psychology_outlined
      , 'text': 'Reduce\nAnxiety', 'key': 'Reduce Anxiety'},
      {'icon': Icons.nightlight_outlined, 'text': 'Better\nSleep', 'key': 'Better Sleep'},
      {'icon': Icons.center_focus_weak_outlined, 'text': 'Improve\nFocus', 'key': 'Improve Focus'},
      {'icon': Icons.self_improvement_outlined, 'text': 'Manage\nStress', 'key': 'Manage Stress'},
      {'icon': Icons.spa_outlined, 'text': 'Mindful-\nness', 'key': 'Mindfulness'},
      {'icon': Icons.person, 'text': 'Self-\nEsteem', 'key': 'Self-Esteem'},
    ];

    final List<Map<String, dynamic>> lastTwoGoals = [
      {'icon': Icons.work_outline, 'text': 'Work-Life Balance', 'key': 'Work-Life Balance'},
      {'icon': Icons.school_outlined, 'text': 'Academic Performance', 'key': 'Academic Performance'},
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stepindicator(currentStep: selectedGoals.length),
              const SizedBox(height: 20),
              const Align(
            alignment: Alignment.centerLeft,
            child: Icon(Icons.arrow_back),
          ),
              const SizedBox(height: 16),
              const Align(alignment:Alignment.center,
                child: Text(
                'Select your Primary Goals',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              ),
              const SizedBox(height: 6),
              const Align(
                alignment:Alignment.center,
                child:Text(
                'Select 3 options that apply to your day.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ), 
              ),
              
             
              const SizedBox(height: 24),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [

                      for (int i = 0; i < firstSixGoals.length; i += 2)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Row(
                            children: [
                              Expanded(
                                child: GoalTile(
                                  icon: firstSixGoals[i]['icon'],
                                  text: firstSixGoals[i]['text'],
                                  isSelected: selectedGoals.contains(firstSixGoals[i]['key']),
                                  onTap: () => toggleGoal(firstSixGoals[i]['key']),
                                ),
                              ),
                              const SizedBox(width: 12),
                              if (i + 1 < firstSixGoals.length)
                                Expanded(
                                  child: GoalTile(
                                    icon: firstSixGoals[i + 1]['icon'],
                                    text: firstSixGoals[i + 1]['text'],
                                    isSelected: selectedGoals.contains(firstSixGoals[i + 1]['key']),
                                    onTap: () => toggleGoal(firstSixGoals[i + 1]['key']),
                                  ),
                                ),
                            ],
                          ),
                        ),
                 
                      for (var goal in lastTwoGoals)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Align(
                            alignment:Alignment.centerLeft,
                            child:IntrinsicWidth(child: GoalTile(
                              icon: goal['icon'],
                              text: goal['text'],
                              
                              isSelected: selectedGoals.contains(goal['key']),
                              onTap: () => toggleGoal(goal['key']),
                              spacing: 8,
                              
                             ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),

            const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: selectedGoals.length == maxSelections
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoadingPage(),
                        ),
                      );
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey.shade800,
                foregroundColor: Colors.white,
                disabledBackgroundColor: Colors.grey.shade300,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text(
                'Continue',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
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