import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() =>
      _ChangePasswordScreenState();
}

class _ChangePasswordScreenState
    extends State<ChangePasswordScreen> {

  final _currentController = TextEditingController();
  final _newController = TextEditingController();
  final _confirmController = TextEditingController();

  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;
  bool _showRules = false;
  bool _isLoading = false;

  bool get _isValid {
    return _currentController.text.isNotEmpty &&
        _newController.text.length >= 8 &&
        _newController.text == _confirmController.text;
  }

  @override
  void dispose() {
    _currentController.dispose();
    _newController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_isValid) return;

    setState(() => _isLoading = true);

    try {
      final response = await http.post(
        Uri.parse("http://10.0.2.2:5000/api/user/change-password"),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "currentPassword": _currentController.text,
          "newPassword": _newController.text,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data["message"] ?? "Password updated")),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data["message"] ?? "Something went wrong")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Unable to connect to server")),
      );
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// Top Bar
              SizedBox(
                height: 50,
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new, size: 20),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Expanded(
                      child: Center(
                        child: Text(
                          "Change Password",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 40)
                  ],
                ),
              ),

              const SizedBox(height: 30),

              _passwordField(
                controller: _currentController,
                hint: "Enter Current Password",
                obscure: _obscureCurrent,
                toggle: () {
                  setState(() {
                    _obscureCurrent = !_obscureCurrent;
                  });
                },
              ),

              const SizedBox(height: 16),

              _passwordField(
                controller: _newController,
                hint: "Enter new password",
                obscure: _obscureNew,
                toggle: () {
                  setState(() {
                    _obscureNew = !_obscureNew;
                  });
                },
              ),

              const SizedBox(height: 16),

              _passwordField(
                controller: _confirmController,
                hint: "Re-enter new password",
                obscure: _obscureConfirm,
                toggle: () {
                  setState(() {
                    _obscureConfirm = !_obscureConfirm;
                  });
                },
              ),

              const SizedBox(height: 22),

              GestureDetector(
                onTap: () {
                  setState(() {
                    _showRules = !_showRules;
                  });
                },
                child: Row(
                  children: [
                    const Text(
                      "Your password must contain:",
                      style: TextStyle(fontSize: 13),
                    ),
                    const Spacer(),
                    Icon(
                      _showRules
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                    )
                  ],
                ),
              ),

              if (_showRules)
                const Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Text(
                    "• At least 8 characters\n"
                    "• One uppercase letter\n"
                    "• One lowercase letter\n"
                    "• One number\n"
                    "• One special character",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ),

              const Spacer(),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _isValid && !_isLoading ? _submit : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isValid
                        ? Colors.black
                        : const Color(0xFFD9D9D9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                    elevation: 0,
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        )
                      : const Text(
                          "Save Password",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),

              const SizedBox(height: 10),

              const Center(
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _passwordField({
    required TextEditingController controller,
    required String hint,
    required bool obscure,
    required VoidCallback toggle,
  }) {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: const Color(0xFFE9E9E9),
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        onChanged: (_) => setState(() {}),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          prefixIcon: const Icon(Icons.lock_outline),
          suffixIcon: IconButton(
            icon: Icon(
              obscure
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
            ),
            onPressed: toggle,
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }
}
