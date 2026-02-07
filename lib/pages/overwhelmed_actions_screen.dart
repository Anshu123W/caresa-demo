import 'package:firstproduction_pro/backend/backend.dart';
import 'package:flutter/material.dart';
import '../navigation/routes.dart';

class OverwhelmedActionsScreen extends StatefulWidget {
  final int questionid_4;
  const OverwhelmedActionsScreen({Key? key,required this.questionid_4}) : super(key: key);

  @override
  State<OverwhelmedActionsScreen> createState() => _OverwhelmedActionsScreenState();
}

class _OverwhelmedActionsScreenState extends State<OverwhelmedActionsScreen> {

  final List<_ActionItem> actions = [
    _ActionItem("Take a walk", Icons.directions_walk_rounded),
    _ActionItem("Talk to someone", Icons.chat_bubble_outline_rounded),
    _ActionItem("Scroll on phone", Icons.phone_android_rounded),
    _ActionItem("Isolate myself", Icons.person_outline_rounded),
    _ActionItem("Practice deep breathing", Icons.self_improvement_rounded),
    _ActionItem("Skip meals", Icons.no_food_rounded),
    _ActionItem("Journal", Icons.menu_book_rounded),
  ];

  bool get allAnswered => actions.every((action) => action.helpsMe != null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Step 4 of 16", // Keeping the "Step" naming consistent
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "What do you typically do when feeling overwhelmed or down?",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1A1A),
                height: 1.3,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemCount: actions.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  return _ActionTile(
                    item: actions[index],
                    onChanged: () => setState(() {}),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: allAnswered
                    ? () async{
                      final List<int> answer=actions.map<int>((action){
                      if (action.helpsMe == true) return 1;
                      if (action.helpsMe == false) return 0;
                      return 0;
                      }).toList();
                      final success=await sendresponse(
                
                        questionIds: [widget.questionid_4], 
                        answers: [answer]);
                     if (success){
                      Navigator.pushNamed(context, Routes.m5support);
                     }else{
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to save response!')));
                     }
                    }
                    //  Navigator.pushNamed(context, Routes.m5support) // Or your support level route
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  disabledBackgroundColor: Colors.grey.shade200,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  "Continue",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: allAnswered ? Colors.white : Colors.grey.shade500,
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
}

class _ActionItem {
  final String label;
  final IconData icon;
  bool? helpsMe;
  _ActionItem(this.label, this.icon);
}

class _ActionTile extends StatelessWidget {
  final _ActionItem item;
  final VoidCallback onChanged;

  const _ActionTile({required this.item, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9F9),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: item.helpsMe != null ? Colors.black12 : Colors.transparent,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(item.icon, size: 24, color: Colors.black87),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  item.label,
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _SegmentButton(
                  text: "Helps me",
                  selected: item.helpsMe == true,
                  onTap: () {
                    item.helpsMe = true;
                    onChanged();
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _SegmentButton(
                  text: "Doesn't help",
                  selected: item.helpsMe == false,
                  onTap: () {
                    item.helpsMe = false;
                    onChanged();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SegmentButton extends StatelessWidget {
  final String text;
  final bool selected;
  final VoidCallback onTap;

  const _SegmentButton({required this.text, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: selected ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: selected ? Colors.black : Colors.grey.shade300),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: selected ? Colors.white : Colors.black54,
            ),
          ),
        ),
      ),
    );
  }
}