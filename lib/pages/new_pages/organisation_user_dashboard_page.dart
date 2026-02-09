import 'package:flutter/material.dart';

class OrganisationUserDashboardPage extends StatelessWidget {
  const OrganisationUserDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: AppBar(
        title: const Text("Organisation Dashboard"),
      ),
      body: const Center(
        child: Text(
          "Organisation User Dashboard",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
