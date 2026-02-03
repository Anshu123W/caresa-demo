import 'package:flutter/material.dart';

class GoalTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool isSelected;
  final VoidCallback onTap;
  final double spacing;
  const GoalTile({
    super.key,
    required this.icon,
    required this.text,
    this.isSelected = false,
    required this.onTap,
    this.spacing=8,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Colors.black : const Color.fromARGB(255, 0, 0, 0),
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(30),
          color: const Color.fromARGB(255, 255, 255, 255),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: const Color.fromARGB(255, 0, 0, 0),
              opticalSize: 28,
              size: 33,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: isSelected ? FontWeight.bold: FontWeight.normal,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(width: spacing,),
            Container(
              height: 25,
              width: 25,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? Colors.black : const Color.fromARGB(255, 0, 0, 0),
                  width: isSelected ? 1: 1,
                ),
                color: isSelected ? Colors.black:Colors.transparent,
              ),
              child: isSelected
                  ? const Icon(
                      Icons.check,
                      color: Colors.white,
                      weight: 100,

                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}