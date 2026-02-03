import 'package:flutter/material.dart';
import 'uni_create_account_screen.dart'; // Ensure this matches your filename

class UniversityVerification extends StatefulWidget {
  const UniversityVerification({super.key});

  @override
  State<UniversityVerification> createState() => _UniversityVerificationState();
}

class _UniversityVerificationState extends State<UniversityVerification> {
  final TextEditingController universityController = TextEditingController();
  final TextEditingController codeController = TextEditingController();

  bool isButtonEnabled = false;

  // Logic to check if fields are filled
  void checkFields() {
    setState(() {
      isButtonEnabled = universityController.text.trim().isNotEmpty &&
          codeController.text.trim().isNotEmpty;
    });
  }

  @override
  void dispose() {
    universityController.dispose();
    codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          "University Verification",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 40),
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                shape: BoxShape.circle,
                boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
              ),
              child: const Icon(Icons.account_balance_outlined, size: 40, color: Colors.black54),
            ),
            const SizedBox(height: 30),
            const Text("Verify Your Access", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const Text(
              "Your responses remain private from your university.\n“We prioritize your mental sanctuary”",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
            const SizedBox(height: 30),
            
            // Verification Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 15)],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("University name :", style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  _inputField(
                    hint: 'e.g. SPPU',
                    icon: Icons.school_outlined,
                    controller: universityController,
                  ),
                  const SizedBox(height: 16),
                  const Text("Enter university code or email :", style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  _inputField(
                    hint: 'e.g. UNI123 or student@university.edu',
                    icon: Icons.email_outlined,
                    controller: codeController,
                  ),
                  const SizedBox(height: 20),
                  
                  // FIXED BUTTON LOGIC
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: isButtonEnabled
                          ? () => Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const UniCreateAccountScreen()),
                              )
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isButtonEnabled ? Colors.black : Colors.grey.shade300,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                        elevation: 0,
                      ),
                      child: const Text("Continue", style: TextStyle(fontSize: 16, color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
      bottomNavigationBar: _buildSecureFooter(),
    );
  }

  Widget _buildSecureFooter() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.lock_outline, size: 14, color: Colors.black54),
          SizedBox(width: 6),
          Text("SECURE ENCRYPTED VERIFICATION", style: TextStyle(fontSize: 12, color: Colors.black54, letterSpacing: 0.5)),
        ],
      ),
    );
  }

  Widget _inputField({required String hint, required IconData icon, required TextEditingController controller}) {
    return TextField(
      controller: controller,
      onChanged: (_) => checkFields(), // Trigger validation on every keystroke
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.grey),
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
      ),
    );
  }
}