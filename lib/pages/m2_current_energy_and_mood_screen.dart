import 'package:firstproduction_pro/backend/backend.dart';
import 'package:flutter/material.dart';
import '../navigation/routes.dart';

class MoodSelectionScreen extends StatefulWidget {
  final int questionid_2;
  const MoodSelectionScreen({super.key,required this.questionid_2});

  @override
  State<MoodSelectionScreen> createState() => _MoodSelectionScreenState();
}

class _MoodSelectionScreenState extends State<MoodSelectionScreen> {
  String? selectedMood;
    final Map<String, int> moodanswerids = {
    'Drained': 1,
    'Low': 2,
    'Neutral': 3,
    'Good':4,
    'Energetic':5
  };
  final List<Map<String, String>> moods = [
    {'label': 'Drained', 'emoji': '😫'},
    {'label': 'Low', 'emoji': '😔'},
    {'label': 'Neutral', 'emoji': '😐'},
    {'label': 'Good', 'emoji': '🙂'}, // Added to balance the scale
    {'label': 'Energetic', 'emoji': '🤩'},
  ];

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
        title: const Text(
          'Question 2 of 16',
          style: TextStyle(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            const Text(
              'Over the past week, how would you describe your overall energy and mood?',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1A1A),
                height: 1.3,
              ),
            ),
            const SizedBox(height: 60),
            
            // Mood Options Wrap (better for various screen sizes)
            Center(
              child: Wrap(
                spacing: 20,
                runSpacing: 20,
                alignment: WrapAlignment.center,
                children: moods.map((mood) {
                  bool isSelected = selectedMood == mood['label'];
                  return GestureDetector(
                    onTap: () => setState(() => selectedMood = mood['label']),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                      width: 100,
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.grey.shade50 : Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected ? Colors.black : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: Column(
                        children: [
                          Text(
                            mood['emoji']!,
                            style: TextStyle(
                              fontSize: 48,
                              // Desaturate non-selected emojis slightly for focus
                              color: isSelected ? null : Colors.white.withOpacity(0.5),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            mood['label']!,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                              color: isSelected ? Colors.black : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            
            const Spacer(),
            
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: selectedMood != null 
                  ? () async{
                    int answer_id=moodanswerids[selectedMood]!;
                    final success=await sendresponse(
                   
                      questionIds:[widget.questionid_2], 
                      answers: [[answer_id]]
                      );
                    if (success){
                       Navigator.pushNamed(context, Routes.m3primary);
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to save response!')));
                    }
                  }
                  // Navigator.pushNamed(context, Routes.m3primary) 
                  : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  disabledBackgroundColor: Colors.grey.shade200,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Continue',
                  style: TextStyle(
                    color: selectedMood != null ? Colors.white : Colors.grey.shade500,
                    fontSize: 16,
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
}