import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

import 'organisation_user_dashboard_page.dart';
import 'login_page.dart';

class OrganisationUserSignupPage extends StatefulWidget {
  const OrganisationUserSignupPage({super.key});

  @override
  State<OrganisationUserSignupPage> createState() =>
      _OrganisationUserSignupPageState();
}

class _OrganisationUserSignupPageState
    extends State<OrganisationUserSignupPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLoading = false;

  // Replace with your organisation ID
  final String organisationId = "fc77bd44-d99d-4278-bd7a-b269e238826c";

  // Auto-detect base URL
  String get baseUrl =>
      kIsWeb ? "http://localhost:5000" : "http://10.0.2.2:5000";

  Future<void> signupOrgUser() async {
    setState(() => isLoading = true);

    try {
      final response = await http.post(
        Uri.parse("$baseUrl/api/org-user/signup"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "fullName": nameController.text.trim(),
          "email": emailController.text.trim(),
          "password": passwordController.text.trim(),
          "organisationId": organisationId,
        }),
      );

      print("STATUS: ${response.statusCode}");
      print("BODY: ${response.body}");

      final data = jsonDecode(response.body);

      if (!mounted) return;

      if (response.statusCode == 201) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const OrganisationUserDashboardPage(),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data["error"] ?? "Signup failed")),
        );
      }
    } catch (e) {
      print("ERROR: $e");
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Server error")),
      );
    }

    if (mounted) {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Organisation Signup")),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Full Name"),
              ),
              const SizedBox(height: 16),

              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: "Email"),
              ),
              const SizedBox(height: 16),

              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: "Password"),
              ),
              const SizedBox(height: 16),

              TextField(
                enabled: false,
                decoration: const InputDecoration(
                  labelText: "Organisation",
                  hintText: "Auto-filled",
                ),
              ),

              const SizedBox(height: 32),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isLoading ? null : signupOrgUser,
                  child: isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text("Create Account"),
                ),
              ),

              const SizedBox(height: 20),

              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const LoginPage(),
                    ),
                  );
                },
                child: const Text("Already have an account? Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
