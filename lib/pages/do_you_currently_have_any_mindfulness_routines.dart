import 'package:firstproduction_pro/backend/backend.dart';
import 'package:flutter/material.dart';

class MindfulnessRoutineScreen extends StatefulWidget {
  final int questionid_8;
  const MindfulnessRoutineScreen({Key? key,required this.questionid_8}) : super(key: key);

  @override
  State<MindfulnessRoutineScreen> createState() => _MindfulnessRoutineScreenState();
}

class _MindfulnessRoutineScreenState extends State<MindfulnessRoutineScreen> {
  final Map<String, int> mindfulnessAnswerMap = {
  'Yes, regularly': 1,
  'Yes, sometimes': 1,
  'No': 0,
};

  String? selectedOption;
  final TextEditingController detailsController = TextEditingController();

  // Logic to determine if we should show the extra input field
  bool get showDetailsInput =>
      selectedOption == 'Yes, regularly' || selectedOption == 'Yes, sometimes';

  @override
  void dispose() {
    detailsController.dispose();
    super.dispose();
  }

  // Refactored logic to handle the "Continue" action
  void _handleNavigation() async{
    // You can pass the selected data to the next screen or save to a state provider
      final int answerId = mindfulnessAnswerMap[selectedOption]!;

    final success = await sendresponse(
    
    questionIds: [widget.questionid_8], // replace 8 with your questionId variable if needed
    answers: [[answerId]],
  );


  if(success){
    Navigator.pushNamed(context, '/stress');

  }else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Failed to save response!')),
    );
  }
}

  Widget _optionTile(String text) {
    final bool isSelected = selectedOption == text;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(bottom: 14),
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedOption = text;
            if (text == 'No') detailsController.clear();
          });
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 18),
          decoration: BoxDecoration(
            // Visual feedback: Highlight selection with primary color or grey
            color: isSelected ? Colors.black.withOpacity(0.05) : Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isSelected ? Colors.black : Colors.grey.shade300,
              width: isSelected ? 2 : 1,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              color: isSelected ? Colors.black : Colors.black87,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        centerTitle: true,
        title: Column(
          children: [
            const Text(
              'Question 8 of 16',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            const SizedBox(height: 4),
            // Progress indicator bar for better UX
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                width: 100,
                height: 4,
                child: LinearProgressIndicator(
                  value: 8 / 16, // Progress ratio
                  backgroundColor: Colors.grey.shade200,
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 32),
            const Text(
              "Do you currently have any routines for mindfulness, relaxation, or dedicated 'you-time'?",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.5,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 32),
            
            _optionTile('Yes, regularly'),
            _optionTile('Yes, sometimes'),
            _optionTile('No'),

            // Animated visibility for the extra input field
            AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: showDetailsInput ? 1.0 : 0.0,
              child: Visibility(
                visible: showDetailsInput,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: TextField(
                    controller: detailsController,
                    maxLines: 2,
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: "What kind? (e.g., meditation, reading)",
                      hintStyle: TextStyle(color: Colors.grey.shade400),
                      filled: true,
                      fillColor: Colors.grey.shade50,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const Spacer(),

            // Primary Action Button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: selectedOption == null ? null :_handleNavigation,
                
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  disabledBackgroundColor: Colors.grey.shade300,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'CONTINUE',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}