import 'package:firstproduction_pro/backend/backend.dart';
import 'package:flutter/material.dart';

class M4InsightsScreen extends StatefulWidget {
  final int questionid_15;
  
  const M4InsightsScreen({Key? key, required this.questionid_15}) : super(key: key);

  @override
  State<M4InsightsScreen> createState() => _M4InsightsScreenState();
}

class _M4InsightsScreenState extends State<M4InsightsScreen> {
  final Map<String, int> insightOptionIds = {
    "Emotional Baseline": 101,
    "Lifestyle Habits": 102,
    "Personal Context": 103,
  };

  // Track selected cards
  final Set<String> selectedInsights = {};
  bool isSaving = false;

  Future<void> _saveInsights() async {
    setState(() => isSaving = true);

    final List<int> answerIds =
        selectedInsights.map((opt) => insightOptionIds[opt]!).toList();

    final success = await sendresponse(
 
      questionIds: [widget.questionid_15],
      answers: [answerIds],
    );

    setState(() => isSaving = false);

    if (success) {
      Navigator.pushNamed(context, '/m4processing');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to save insights!')),
      );
    }
  }

  void _toggleInsight(String insight) {
    setState(() {
      if (selectedInsights.contains(insight)) {
        selectedInsights.remove(insight);
      } else {
        selectedInsights.add(insight);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF2D2D2D)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Review your Insights',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF2D2D2D),
                  height: 1.2,
                  letterSpacing: -0.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                '"Thank you for your openness. Select the insights you\'d like to review."',
                style: TextStyle(
                  fontSize: 15,
                  color: const Color(0xFF2D2D2D).withOpacity(0.6),
                  fontStyle: FontStyle.italic,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              _InsightCard(
                title: 'Your Emotional Baseline',
                isSelected: selectedInsights.contains('Emotional Baseline'),
                onTap: () => _toggleInsight('Emotional Baseline'),
              ),
              const SizedBox(height: 16),
              _InsightCard(
                title: 'Your Lifestyle Habits',
                isSelected: selectedInsights.contains('Lifestyle Habits'),
                onTap: () => _toggleInsight('Lifestyle Habits'),
              ),
              const SizedBox(height: 16),
              _InsightCard(
                title: 'Your Personal Context',
                isSelected: selectedInsights.contains('Personal Context'),
                onTap: () => _toggleInsight('Personal Context'),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: selectedInsights.isEmpty || isSaving ? null : _saveInsights,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedInsights.isEmpty
                        ? const Color(0xFFBDBDBD)
                        : Colors.black,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: const Color(0xFFBDBDBD),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: isSaving
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2.5,
                          ),
                        )
                      : const Text(
                          'Looks good, see your insights',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.3,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class _InsightCard extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _InsightCard({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected ? Colors.black : const Color(0xFF3D3D3D),
      borderRadius: BorderRadius.circular(16),
      elevation: isSelected ? 2 : 0,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected ? Colors.black : Colors.transparent,
              width: 2,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    letterSpacing: 0.2,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              if (isSelected)
                const Icon(
                  Icons.check_circle,
                  color: Colors.white,
                  size: 24,
                ),
            ],
          ),
        ),
      ),
    );
  }
}