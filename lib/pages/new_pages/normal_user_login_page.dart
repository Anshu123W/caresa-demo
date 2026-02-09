import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

import 'normal_user_dashboard_page.dart';

class NormalUserLoginPage extends StatefulWidget {
  const NormalUserLoginPage({super.key});

  @override
  State<NormalUserLoginPage> createState() =>
      _NormalUserLoginPageState();
}

class _NormalUserLoginPageState
    extends State<NormalUserLoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLoading = false;

  String get baseUrl =>
      kIsWeb ? "http://localhost:5000" : "http://10.0.2.2:5000";

  Future<void> login() async {
    setState(() => isLoading = true);

    try {
      final response = await http.post(
        Uri.parse("$baseUrl/api/login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": emailController.text.trim(),
          "password": passwordController.text.trim(),
        }),
      );

      final data = jsonDecode(response.body);

      if (!mounted) return;

      if (response.statusCode == 200) {
        final role = data["role"];

        // 🔴 Only allow normal users
        if (role == "normal_user") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => const NormalUserDashboardPage(),
            ),
          );
        } else {
          // Block HR and organisation users
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                  "This login is only for normal users."),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text(data["error"] ?? "Invalid credentials")),
        );
      }
    } catch (e) {
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
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: AppBar(title: const Text("User Login")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration:
                  const InputDecoration(labelText: "Email"),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: passwordController,
              obscureText: true,
              decoration:
                  const InputDecoration(labelText: "Password"),
            ),
            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isLoading ? null : login,
                child: isLoading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text("Login"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
