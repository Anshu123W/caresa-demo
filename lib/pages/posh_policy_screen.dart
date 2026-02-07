import 'package:flutter/material.dart';
// Import your screens here
import 'verbal_harassment_screen.dart';
 import 'physical_harassment_screen.dart';

class PoshPolicyScreen extends StatelessWidget {
  const PoshPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.black, size: 28),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Posh Policy',
          style: TextStyle(
            color: Colors.black, 
            fontWeight: FontWeight.w800, 
            fontSize: 22,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Illustration Container
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Center(
                child: Container(
                  height: 220,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE6F0FF),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Icon(Icons.security_sharp, size: 80, color: Color(0xFF4A90E2)),
                ),
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Learn about our guidelines and standards for a respectful and a safe workplace.',
                    style: TextStyle(
                      color: Color(0xFF7D7D7D),
                      fontSize: 15,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // 1. Verbal Harassment Clickable
                  _buildPolicyItem(
                    context, 
                    'Verbal Harassment', 
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const VerbalHarassmentScreen())),
                  ),

                  // 2. Physical Harassment Clickable
                  _buildPolicyItem(
                    context, 
                    'Physical Harassment',
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const PhysicalHarassmentScreen())),
                  ),

                  // 3. Other items (Placeholder logic)
                  _buildPolicyItem(context, 'Visual / Digital Harassment', onTap: () {}),
                  _buildPolicyItem(context, 'Workplace Definition', onTap: () {}),
                  _buildPolicyItem(context, 'Upload Evidence', onTap: () {}),

                  const SizedBox(height: 32),

                  SizedBox(
                    width: double.infinity,
                    height: 58,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFD1D1D1),
                        foregroundColor: Colors.white,
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text('Continue', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Updated helper method with an onTap parameter
  Widget _buildPolicyItem(BuildContext context, String title, {required VoidCallback onTap}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1.2),
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold, 
            fontSize: 18,
            letterSpacing: -0.5,
          ),
        ),
        trailing: const Icon(Icons.chevron_right, color: Colors.black54),
        onTap: onTap, // Now uses the callback passed into the function
      ),
    );
  }
}