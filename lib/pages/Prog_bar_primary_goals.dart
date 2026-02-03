import 'package:flutter/material.dart';

class Stepindicator extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  
  const Stepindicator({super.key,
    this.currentStep = 0,
    this.totalSteps = 3,});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'STEP $currentStep OF $totalSteps ',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 12,
            letterSpacing: 1.2,
          ),
        ),
                const SizedBox(height: 8),
        Row(
          children: List.generate(
            totalSteps,
            (index) => Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  right: index < totalSteps - 1 ? 8 : 0,
                ),
                child: _bar(active: index < currentStep),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _bar({required bool active}) {
    return Container(
      height: 4,
      decoration: BoxDecoration(
        color: active ? Colors.black : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}