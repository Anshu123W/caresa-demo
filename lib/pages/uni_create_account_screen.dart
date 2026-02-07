import 'package:flutter/material.dart';

class UniCreateAccountScreen extends StatefulWidget {
  const UniCreateAccountScreen({super.key});

  @override
  State<UniCreateAccountScreen> createState() => _UniCreateAccountScreenState();
}

class _UniCreateAccountScreenState extends State<UniCreateAccountScreen> {
  bool _isPasswordVisible = false;
  bool _isFormValid = false; // Track if all fields are filled

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _uniController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Listen to changes in all controllers to update button state
    _nameController.addListener(_validateForm);
    _emailController.addListener(_validateForm);
    _passwordController.addListener(_validateForm);
    _uniController.addListener(_validateForm);
  }

  void _validateForm() {
    final isValid = _nameController.text.isNotEmpty &&
        _emailController.text.contains('@') &&
        _passwordController.text.length >= 6 &&
        _uniController.text.isNotEmpty;
    
    if (isValid != _isFormValid) {
      setState(() => _isFormValid = isValid);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _uniController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black54),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Create Your Account',
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.5,
                color: Color(0xFF333333),
              ),
            ),
            const Text(
              'Onboard to a More Balanced Life....',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 25),

            _buildLabel("Full Name"),
            _buildCustomTextField(hint: "John Smith", controller: _nameController),

            _buildLabel("Email Address"),
            _buildCustomTextField(hint: "email@example.com", controller: _emailController, keyboardType: TextInputType.emailAddress),

            _buildLabel("Password"),
            _buildCustomTextField(
              hint: "••••••",
              controller: _passwordController,
              isPassword: true,
              isVisible: _isPasswordVisible,
              onToggle: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
            ),

            _buildLabel("University"),
            _buildCustomTextField(hint: "DTU", controller: _uniController),

            const SizedBox(height: 35),
            _buildMainButton(),

            const SizedBox(height: 30),
            _buildSocialDivider(),
            const SizedBox(height: 25),

            _buildSocialButton(
              "Google",
              logo: Image.network(
                'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_\"G\"_logo.svg/1200px-Google_\"G\"_logo.svg.png',
                height: 22,
              ),
            ),
            const SizedBox(height: 15),
            _buildSocialButton(
              "Ios",
              logo: const Icon(Icons.apple, color: Colors.black, size: 28),
            ),

            const SizedBox(height: 25),
            _buildFooter(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // --- UI Helpers ---

  Widget _buildLabel(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 8, top: 12),
    child: Text(text, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15, color: Colors.black87)),
  );

  Widget _buildCustomTextField({
    required String hint,
    required TextEditingController controller,
    bool isPassword = false,
    bool? isVisible,
    VoidCallback? onToggle,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword && !(isVisible ?? false),
        keyboardType: keyboardType,
        style: const TextStyle(fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 16),
          suffixIcon: isPassword ? IconButton(
            icon: Icon(isVisible! ? Icons.visibility : Icons.visibility_off_outlined, color: Colors.grey.shade400),
            onPressed: onToggle,
          ) : null,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.grey.shade100),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.black26),
          ),
        ),
      ),
    );
  }

  Widget _buildMainButton() {
    return Container(
      width: double.infinity,
      height: 65,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(35),
        boxShadow: _isFormValid ? [
          BoxShadow(color: Colors.black.withOpacity(0.12), blurRadius: 15, offset: const Offset(0, 8)),
        ] : [],
      ),
      child: ElevatedButton(
        onPressed: _isFormValid ? () => Navigator.pushNamed(context, '/primary') : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: _isFormValid ? Colors.black : const Color(0xFFD1D5DB),
          disabledBackgroundColor: const Color(0xFFD1D5DB),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
          elevation: 0,
        ),
        child: const Text(
          'Create Account',
          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  // Social and Footer widgets remain the same...
  Widget _buildSocialDivider() {
    return Row(
      children: [
        const Expanded(child: Divider()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text("OR SIGN UP WITH", style: TextStyle(color: Colors.grey.shade400, fontSize: 12, fontWeight: FontWeight.bold)),
        ),
        const Expanded(child: Divider()),
      ],
    );
  }

  Widget _buildSocialButton(String label, {required Widget logo}) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          side: BorderSide(color: Colors.grey.shade200),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            logo,
            const SizedBox(width: 12),
            Text("Continue with $label", style: const TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Center(
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, '/login'),
        child: RichText(
          text: const TextSpan(
            text: 'Already have an account? ',
            style: TextStyle(color: Colors.grey, fontSize: 15),
            children: [
              TextSpan(text: 'Log In', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}