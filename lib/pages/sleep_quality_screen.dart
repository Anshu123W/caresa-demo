import 'package:firstproduction_pro/backend/backend.dart';
import 'package:flutter/material.dart';
import '../navigation/routes.dart';

class SleepQualityScreen extends StatefulWidget {
  final int questionid_6_1;
  final int questionid_6_2;
  const SleepQualityScreen({super.key,required this.questionid_6_1,required this.questionid_6_2});

  @override
  State<SleepQualityScreen> createState() => _SleepQualityScreenState();
}

class _SleepQualityScreenState extends State<SleepQualityScreen> {
  String? selectedHours;
  String? selectedQuality;
  final Map<String,int> hoursofsleep={
    "5":1,
    "6":2,
    "7":3,
    "8":4,
    "9+":5
  };
  final Map<String,int> qualityMap = {
    "Sound": 2,
    "Fair": 1, 
    "Restless": 0
    };
  bool get isContinueEnabled =>
      selectedHours != null && selectedQuality != null;

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
          "Step 6 of 16",
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
              "On average, how many hours of sleep do you get per night?",
              style: TextStyle(
                fontSize: 24, 
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1A1A),
                height: 1.3,
              ),
            ),
            const SizedBox(height: 24),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: ["5", "6", "7", "8", "9+"].map((hour) {
                return _optionChip(
                  label: hour,
                  isSelected: selectedHours == hour,
                  onTap: () => setState(() => selectedHours = hour),
                );
              }).toList(),
            ),
            const SizedBox(height: 48),
            const Text(
              "How is the quality of your sleep?",
              style: TextStyle(
                fontSize: 24, 
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1A1A),
                height: 1.3,
              ),
            ),
            const SizedBox(height: 24),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: ["Sound", "Fair", "Restless"].map((quality) {
                return _optionChip(
                  label: quality,
                  isSelected: selectedQuality == quality,
                  onTap: () => setState(() => selectedQuality = quality),
                );
              }).toList(),
            ),
            const Spacer(),
            _continueButton(),
            const SizedBox(height: 40),
          ],
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
              final selectedhoursvalue=hoursofsleep[selectedHours!]!;
              final selectedqualityvalue=qualityMap[selectedQuality!]!;
              final success=await sendresponse(
            
                questionIds:[widget.questionid_6_1,widget.questionid_6_2], 
                answers:[[selectedhoursvalue],[selectedqualityvalue]]);
                if(success){
                  Navigator.pushNamed(context, Routes.physicalActivity);
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to save response!')));
                }
            }

            //  Navigator.pushNamed(context, Routes.physicalActivity) 
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

  Widget _optionChip({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : const Color(0xFFF5F5F7),
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: isSelected ? Colors.black : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontSize: 15,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}