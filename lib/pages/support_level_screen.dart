import 'package:firstproduction_pro/backend/backend.dart';
import 'package:flutter/material.dart';
import '../navigation/routes.dart';

class SupportLevelScreen extends StatefulWidget {
  final int questionid_5;
  const SupportLevelScreen({Key? key,required this.questionid_5}) : super(key: key);

  @override
  State<SupportLevelScreen> createState() => _SupportLevelScreenState();
}

class _SupportLevelScreenState extends State<SupportLevelScreen> {
  double _value = 3;
  final Map<String,int> levelnumber={
    "😟":1,
    "😔":2,
    "😄":3,
    "🙂":4,
    "🥰":5,

};
  final List<String> emojis = ["😟", "😔", "😐", "🙂", "🥰"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Step 5 of 16",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "How supported do you feel in your personal life?",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1A1A),
                height: 1.3,
              ),
            ),
            const SizedBox(height: 60),

            /// Emoji Feedback Area
            Center(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return ScaleTransition(scale: animation, child: child);
                },
                child: Text(
                  emojis[_value.round() - 1],
                  key: ValueKey<int>(_value.round()),
                  style: const TextStyle(fontSize: 80),
                ),
              ),
            ),

            const SizedBox(height: 40),

            /// Styled Slider
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: 4,
                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
                overlayShape: const RoundSliderOverlayShape(overlayRadius: 20),
                activeTickMarkColor: Colors.transparent,
                inactiveTickMarkColor: Colors.transparent,
              ),
              child: Slider(
                value: _value,
                min: 1,
                max: 5,
                divisions: 4,
                activeColor: Colors.black,
                inactiveColor: Colors.grey.shade200,
                onChanged: (val) => setState(() => _value = val),
              ),
            ),

            /// Range Labels
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildLabel("I feel\nalone", TextAlign.left),
                  _buildLabel("I have strong\nsupport", TextAlign.right),
                ],
              ),
            ),

            const Spacer(),

            /// Continue Button
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: () async{
                  final String userid='b8a13133-8b32-4b37-a9cb-74ad18992b85';
                  final int questionid=widget.questionid_5;
                  final int answer=levelnumber[emojis[_value.round()-1]]!;
                  final success=await sendresponse(
                
                    questionIds: [questionid], 
                    answers: [[answer]]);
                    if(success){
                       Navigator.pushNamed(context, Routes.m2sleep);
                    }else{
                       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to save response!')));
                    }
                  // Navigator.pushNamed(context, Routes.m2sleep);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "CONTINUE",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    color: Colors.white,
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

  Widget _buildLabel(String text, TextAlign align) {
    return Text(
      text,
      textAlign: align,
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: Colors.grey.shade600,
        height: 1.4,
      ),
    );
  }
}