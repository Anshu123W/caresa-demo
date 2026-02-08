import 'package:flutter/material.dart';
import 'package:firstproduction_pro/navigation/routes.dart';

class HelpHomeScreen extends StatelessWidget {
  const HelpHomeScreen({super.key});
  
  @override
  
  Widget build(BuildContext context) {
  
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Help and Support",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w900, // Matching your bold theme
            fontSize: 22,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            
            // Search Bar with your design aesthetic
            TextField(
              decoration: InputDecoration(
                hintText: 'Search support topics...',
                prefixIcon: const Icon(Icons.search, color: Colors.black54),
                filled: true,
                fillColor: const Color(0xFFF5F5F5),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            
            const SizedBox(height: 35),
            
            _buildSectionHeader("Support Channels"),
            _buildTile(context, Icons.person_search_outlined, "POSH Officer", Routes.help2),
            _buildTile(context, Icons.phone_in_talk_outlined, "Emergency Helpline", Routes.help3),
            _buildTile(context, Icons.psychology_outlined, "Mental Health Support", Routes.help4),
            _buildTile(context, Icons.gavel_outlined, "Report Retaliation", Routes.help5),
            
            const SizedBox(height: 30),
            
            _buildSectionHeader("Safety Resources"),
            _buildTile(context, Icons.shield_outlined, "Workplace Safety", Routes.help6),
            _buildTile(context, Icons.menu_book_outlined, "Anti-Harassment Policy", Routes.poshpolicy),
            _buildTile(context, Icons.favorite_border_rounded, "Mental Wellness", null),
            
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.w800,
          fontSize: 13,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildTile(BuildContext context, IconData icon, String title, String? routeName) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFEEEEEE), width: 1)),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 4),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.04),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: Colors.black, size: 24),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.black26, size: 16),
        onTap: () {
          if (routeName != null) {
            final complaintId =
              ModalRoute.of(context)?.settings.arguments as String?;

            Navigator.pushNamed(context, routeName,arguments:complaintId);
          } else {
            // Handle cases where route isn't ready yet
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Resource coming soon!")),
            );
          }
        },
      ),
    );
  }
}