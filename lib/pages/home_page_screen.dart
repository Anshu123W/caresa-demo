import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
  icon: const Icon(Icons.arrow_back, color: Colors.black),
  onPressed: () {
    Navigator.pop(context); 
  },
),
        title: Row(
          children: [
            const Text('Good Afternoon !', 
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22)),
            const Spacer(),
            _buildDateChip(),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHorizontalCalendar(),
            const SizedBox(height: 20),
            _buildFocusSection(),
            const SizedBox(height: 20),
            _buildMotivationSection(),
            const SizedBox(height: 20),
            _buildRecommendedSession(),
            const SizedBox(height: 100), // Space for FAB
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
      floatingActionButton: _buildFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  // --- UI Components ---

  Widget _buildDateChip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Row(
        children: [
          Text('Tue, 20 Jan', style: TextStyle(color: Colors.black, fontSize: 12)),
          SizedBox(width: 4),
          Icon(Icons.calendar_today, size: 14, color: Colors.purple),
        ],
      ),
    );
  }

  Widget _buildHorizontalCalendar() {
    return SizedBox(
      height: 120,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          _buildDateItem("Fri", "30", "😍"),
          _buildDateItem("Sat", "31", "☹️"),
          _buildDateItem("Sun", "01", "😊", isSelected: true),
          _buildDateItem("Mon", "02", null),
          _buildDateItem("Tue", "03", null),
        ],
      ),
    );
  }

  Widget _buildDateItem(String day, String date, String? emoji, {bool isSelected = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Text(day, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          const SizedBox(height: 4),
          CircleAvatar(
            radius: 25,
            backgroundColor: isSelected ? Colors.purple : Colors.transparent,
            child: Text(date, style: TextStyle(color: isSelected ? Colors.white : Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),
          ),
          if (emoji != null) Text(emoji, style: const TextStyle(fontSize: 20)),
        ],
      ),
    );
  }

  Widget _buildFocusSection() {
    return _buildCardWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Your Focus Today', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const Text('Based on your goals, here\'s what we recommend', style: TextStyle(color: Colors.grey, fontSize: 12)),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildFocusChip("Reduce anxiety"),
              const SizedBox(width: 12),
              _buildFocusChip("Mindfulness"),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildFocusChip(String title) {
    return Expanded(
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.all(12),
        child: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      ),
    );
  }

  Widget _buildMotivationSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              'https://picsum.photos/150', // Replace with your meditation image
              width: 140, height: 140, fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Stay Calm, Mindful & Stress free', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const Text('"A calm mind is a powerful mind."', style: TextStyle(fontStyle: FontStyle.italic, fontSize: 12, color: Colors.grey)),
                const SizedBox(height: 12),
                _buildProgressCard(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildProgressCard() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Daily progress', style: TextStyle(fontSize: 12, color: Colors.grey)),
              Icon(Icons.more_horiz, size: 16),
            ],
          ),
          const Text('3-day Calm streak 🔥', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
          const SizedBox(height: 8),
          LinearProgressIndicator(value: 0.7, backgroundColor: Colors.grey[200], color: Colors.grey[400], minHeight: 6),
        ],
      ),
    );
  }

  Widget _buildRecommendedSession() {
    return _buildCardWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Recommended Session', style: TextStyle(color: Colors.grey, fontSize: 14)),
          const SizedBox(height: 8),
          Container(
            height: 80,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(15),
            ),
            padding: const EdgeInsets.all(16),
            child: const Text('Try a 5 minute stress\nrelief exercise', style: TextStyle(fontWeight: FontWeight.w500)),
          )
        ],
      ),
    );
  }

  Widget _buildCardWrapper({required Widget child}) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, 10))],
      ),
      child: child,
    );
  }

  Widget _buildBottomNav() {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      child: SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _navItem(Icons.home_outlined, "Home", isSelected: true),
            _navItem(Icons.bar_chart, "Stats"),
            const SizedBox(width: 40), // Space for FAB
            _navItem(Icons.assignment_outlined, "History"),
            _navItem(Icons.settings_outlined, "Settings"),
          ],
        ),
      ),
    );
  }

  Widget _navItem(IconData icon, String label, {bool isSelected = false}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: isSelected ? Colors.black : Colors.grey),
        Text(label, style: TextStyle(fontSize: 10, color: isSelected ? Colors.black : Colors.grey)),
      ],
    );
  }

  Widget _buildFab() {
    return FloatingActionButton(
      onPressed: () {},
      backgroundColor: const Color(0xFF9166FF),
      shape: const CircleBorder(),
      child: const Icon(Icons.add, color: Colors.white, size: 30),
    );
  }
}