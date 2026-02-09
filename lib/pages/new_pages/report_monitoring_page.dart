import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/foundation.dart';

class ReportMonitoringPage extends StatefulWidget {
  const ReportMonitoringPage({super.key});

  @override
  State<ReportMonitoringPage> createState() =>
      _ReportMonitoringPageState();
}

class _ReportMonitoringPageState
    extends State<ReportMonitoringPage> {
  String selectedStatus = 'submitted';

  // Auto platform URL
  String get baseUrl =>
      kIsWeb ? "http://localhost:5000" : "http://10.0.2.2:5000";

  Future<void> updateStatus(String status) async {
    setState(() => selectedStatus = status);

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/update-status'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'status': status}),
      );

      debugPrint('HR response: ${response.statusCode}');
    } catch (e) {
      debugPrint('HR error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: AppBar(
        title: const Text('Complaint Control'),
        centerTitle: true,
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

            _sectionTitle('Update Complaint Status'),
            const SizedBox(height: 12),

            _statusButton(
              title: 'Report Submitted',
              value: 'submitted',
            ),
            _statusButton(
              title: 'Under Review by IC',
              value: 'review',
            ),
            _statusButton(
              title: 'Investigation In Progress',
              value: 'investigation',
            ),
            _statusButton(
              title: 'Resolution & Outcome',
              value: 'resolved',
            ),

            const Spacer(),

            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  const Icon(Icons.info_outline, size: 20),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      _helperText(selectedStatus),
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statusButton({
    required String title,
    required String value,
  }) {
    final isActive = selectedStatus == value;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: () => updateStatus(value),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: double.infinity,
          padding:
              const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          decoration: BoxDecoration(
            color: isActive ? Colors.black : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.black),
          ),
          child: Text(
            title,
            style: TextStyle(
              color: isActive ? Colors.white : Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  String _helperText(String status) {
    switch (status) {
      case 'review':
        return 'The Internal Committee has started reviewing the complaint.';
      case 'investigation':
        return 'Investigation is in progress. Interviews or evidence may be required.';
      case 'resolved':
        return 'The complaint has been resolved and closed officially.';
      default:
        return 'The complaint has been successfully submitted.';
    }
  }
}
