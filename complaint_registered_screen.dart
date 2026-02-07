import 'package:flutter/material.dart';
import 'complaint_submitted_screen.dart';

class ComplaintRegisteredScreen extends StatefulWidget {
  const ComplaintRegisteredScreen({super.key});

  @override
  State<ComplaintRegisteredScreen> createState() =>
      _ComplaintRegisteredScreenState();
}

class _ComplaintRegisteredScreenState
    extends State<ComplaintRegisteredScreen> {

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const ComplaintSubmittedScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 40,
              height: 40,
              child: CircularProgressIndicator(
                strokeWidth: 4,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 30),
            Text(
              "Complaint Registered !",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
