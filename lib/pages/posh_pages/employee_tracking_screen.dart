import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import '../widgets/complaint_stepper.dart';

class EmployeeTrackingScreen extends StatefulWidget {
  EmployeeTrackingScreen({super.key});

  @override
  State<EmployeeTrackingScreen> createState() =>
      _EmployeeTrackingScreenState();
}

class _EmployeeTrackingScreenState extends State<EmployeeTrackingScreen> {
  String status = 'submitted';
  Timer? timer;

  @override
  void initState() {
    super.initState();
    fetchStatus();
    timer = Timer.periodic(
      const Duration(seconds: 2),
      (_) => fetchStatus(),
    );
  }

  Future<void> fetchStatus() async {
    final res =
        await http.get(Uri.parse('http://10.0.2.2:3000/status'));

    if (res.statusCode == 200) {
      final newStatus = jsonDecode(res.body)['status'];
      if (newStatus != status) {
        setState(() => status = newStatus);
      }
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isResolved = status == 'resolved';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Complaint Tracking'),
        leading: const BackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Case ID: POSH-2026-1234',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),

            ComplaintStepper(currentStatus: status),

            const SizedBox(height: 30),

            const Text(
              'Messages & Updates',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),

            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(_getMessage(status)),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isResolved ? () {} : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      isResolved ? Colors.black : Colors.grey.shade300,
                  foregroundColor: Colors.white,
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Continue'),
              ),
            )
          ],
        ),
      ),
    );
  }

  String _getMessage(String status) {
    switch (status) {
      case 'review':
        return 'Your report is under review by IC.';
      case 'investigation':
        return 'System Update: Investigation phase initiated. '
            'An IC member will contact you shortly if additional '
            'witnesses or documentation are required.\nStatus: Active';
      case 'resolved':
        return 'Your complaint has been resolved.';
      default:
        return 'Report submitted successfully.';
    }
  }
}
