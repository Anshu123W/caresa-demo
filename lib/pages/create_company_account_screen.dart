import 'package:flutter/material.dart';

class CompanyCreateAccountScreen extends StatefulWidget {
  const CompanyCreateAccountScreen({super.key});

  @override
  State<CompanyCreateAccountScreen> createState() => _CompanyCreateAccountScreenState();
}

class _CompanyCreateAccountScreenState extends State<CompanyCreateAccountScreen> {
  bool _isPasswordVisible = false;
  
  // Controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _orgController = TextEditingController(text: "Careasa (Autofill)"); 
  final TextEditingController _roleController = TextEditingController();

  // State variable for button validation
  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    // Add listeners to all controllers to validate the form on every keystroke
    _nameController.addListener(_validateForm);
    _emailController.addListener(_validateForm);
    _passwordController.addListener(_validateForm);
    _orgController.addListener(_validateForm);
    _roleController.addListener(_validateForm);
    
    // Initial check in case some fields are pre-filled
    _validateForm();
  }

  void _validateForm() {
    final bool isValid = _nameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _orgController.text.isNotEmpty &&
        _roleController.text.isNotEmpty;

    if (isValid != _isFormValid) {
      setState(() {
        _isFormValid = isValid;
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _orgController.dispose();
    _roleController.dispose();
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
                fontStyle: FontStyle.italic
              ),
            ),
            const SizedBox(height: 25),

            _buildLabel("Full Name"),
            _buildCustomTextField(hint: "John Smith", controller: _nameController),
            
            _buildLabel("Email Address"),
            _buildCustomTextField(hint: "email@example.com", controller: _emailController),
            
            _buildLabel("Password"),
            _buildCustomTextField(
              hint: "••••••••", 
              controller: _passwordController,
              isPassword: true, 
              isVisible: _isPasswordVisible,
              onToggle: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
            ),
            
            _buildLabel("Organization"),
            _buildCustomTextField(hint: "Careasa (Autofill)", controller: _orgController),

            _buildLabel("Role"),
            _buildCustomTextField(hint: "e.g. Manager", controller: _roleController),

            const SizedBox(height: 40), // Increased spacing for a cleaner look
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

  Widget _buildLabel(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 8, top: 12),
    child: Text(
      text, 
      style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15, color: Colors.black87)
    ),
  );

  Widget _buildCustomTextField({
    required String hint, 
    required TextEditingController controller,
    bool isPassword = false, 
    bool? isVisible, 
    VoidCallback? onToggle,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
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
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 16),
          suffixIcon: isPassword ? IconButton(
            icon: Icon(isVisible! ? Icons.visibility : Icons.visibility_off, color: Colors.grey.shade400),
            onPressed: onToggle,
          ) : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Colors.grey.shade100),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 25, vertical: 18),
        ),
      ),
    );
  }

  Widget _buildMainButton() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300), // Smooth color transition
      width: double.infinity,
      height: 65,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(35),
        boxShadow: [
          BoxShadow(
            // Shadow becomes slightly more prominent when active
            color: _isFormValid ? Colors.black.withOpacity(0.25) : Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ElevatedButton(
        // Disable click if form is not valid
        onPressed: _isFormValid ? () => Navigator.pushNamed(context, '/primary') : null,
        style: ElevatedButton.styleFrom(
          // Logic: Black if valid, Greyish-Blue if invalid
          backgroundColor: _isFormValid ? const Color(0xFF000000) : const Color(0xFFD1D5DB),
          disabledBackgroundColor: const Color(0xFFD1D5DB), // Ensures color stays same when null
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
          elevation: 0,
        ),
        child: const Text(
          'Create Account', 
          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)
        ),
      ),
    );
  }

  // Divider and Social Buttons remain the same...
  Widget _buildSocialDivider() {
    return Row(
      children: [
        const Expanded(child: Divider()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            "OR SIGN UP WITH", 
            style: TextStyle(color: Colors.grey.shade400, fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ),
        const Expanded(child: Divider()),
      ],
    );
  }

  Widget _buildSocialButton(String provider, {required Widget logo}) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          side: BorderSide(color: Colors.grey.shade200, width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            logo,
            const SizedBox(width: 12),
            Text(
              "Continue with $provider", 
              style: const TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w500)
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Already have an account? ', style: TextStyle(color: Colors.grey, fontSize: 15)),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, '/login'),
          child: const Text(
            'Log In', 
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15)
          ),
        ),
      ],
    );
  }
}