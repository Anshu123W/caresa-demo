import 'package:firstproduction_pro/backend/backend.dart';
import 'package:flutter/material.dart';
import '../navigation/routes.dart';

class PhysicalActivityScreen extends StatefulWidget {
  final int questionid_7;
  const PhysicalActivityScreen({super.key,required this.questionid_7});

  @override
  State<PhysicalActivityScreen> createState() => _PhysicalActivityScreenState();
}

class _PhysicalActivityScreenState extends State<PhysicalActivityScreen> {
  String? selectedOption;

  bool get isContinueEnabled => selectedOption != null;
  
  final Map<String,int> activityOptionsselectedlist = {
    "Rarely":1,
    "1-2 days a week":2,
    "3-4 days a week":3,
    "5+ days a week":4
};
  final List<String> activityOptions = [
    "Rarely",
    "1-2 days a week",
    "3-4 days a week",
    "5+ days a week"
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
        centerTitle: true,
        title: const Text(
          "Step 7 of 16",
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
              "How often are you physically active for at least 20 minutes?",
              style: TextStyle(
                fontSize: 24, 
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1A1A),
                height: 1.3,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "This includes walking, yoga, or any workout.",
              style: TextStyle(color: Colors.grey.shade500, fontSize: 15),
            ),
            const SizedBox(height: 40),

            // Options List
            Expanded(
              child: ListView.builder(
                itemCount: activityOptions.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _optionButton(activityOptions[index]),
                  );
                },
              ),
            ),

            _continueButton(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _optionButton(String label) {
    final isSelected = selectedOption == label;

    return GestureDetector(
      onTap: () => setState(() => selectedOption = label),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : const Color(0xFFF9F9F9),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected ? Colors.black : Colors.grey.shade200,
            width: 1.5,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              color: isSelected ? Colors.white : Colors.black87,
            ),
          ),
        ),
      ),
    );
  }

  Widget _continueButton() {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: isContinueEnabled 
            ? () async{
                    int answer_id=activityOptionsselectedlist[selectedOption]!;
                    final success=await sendresponse(
                    
                      questionIds:[widget.questionid_7], 
                      answers: [[answer_id]]
                      );
                    if (success){
                       Navigator.pushNamed(context, Routes.m2mindfulness);
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to save response!')));
                    }
                  }
            //  Navigator.pushNamed(context, Routes.m2mindfulness) 
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          disabledBackgroundColor: Colors.grey.shade200,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          elevation: 0,
        ),
        child: Text(
          "CONTINUE",
          style: TextStyle(
            color: isContinueEnabled ? Colors.white : Colors.grey.shade500,
            fontWeight: FontWeight.bold,
            fontSize: 16,
            letterSpacing: 1.2,
          ),
        ),
      ),
    );
  }
}