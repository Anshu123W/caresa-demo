import 'package:flutter/material.dart';

class NormalUserDashboardPage extends StatelessWidget {
  const NormalUserDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _header(),
                    const SizedBox(height: 20),
                    _dateSelector(),
                    const SizedBox(height: 15),
                    _moodRow(),
                    const SizedBox(height: 20),
                    _focusCard(),
                    const SizedBox(height: 20),
                    _motivationSection(),
                    const SizedBox(height: 20),
                    _recommendedSession(),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),
            _bottomNav(),
          ],
        ),
      ),
    );
  }

  // ---------------- HEADER ----------------
  Widget _header() {
    return Row(
      children: [
        const Icon(Icons.arrow_back),
        const SizedBox(width: 10),
        const Text(
          "Good Afternoon !",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Row(
            children: [
              Text("Tue, 20 Jan"),
              SizedBox(width: 6),
              Icon(Icons.calendar_today, size: 16, color: Colors.purple),
            ],
          ),
        )
      ],
    );
  }

  // ---------------- DATE SELECTOR ----------------
  Widget _dateSelector() {
    final days = [
      {"day": "Fri", "date": "30"},
      {"day": "Sat", "date": "31"},
      {"day": "Sun", "date": "01"},
      {"day": "Mon", "date": "02"},
      {"day": "Tue", "date": "03"},
      {"day": "Wed", "date": "04"},
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: days.map((d) {
        final isSelected = d["day"] == "Sun";
        return Column(
          children: [
            Text(d["day"]!),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: isSelected
                  ? BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Colors.purple, Colors.deepPurple],
                      ),
                      borderRadius: BorderRadius.circular(30),
                    )
                  : null,
              child: Text(
                d["date"]!,
                style: TextStyle(
                  fontSize: 18,
                  color: isSelected ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  // ---------------- MOOD ROW ----------------
  Widget _moodRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: const [
        Text("😍", style: TextStyle(fontSize: 28)),
        Text("😞", style: TextStyle(fontSize: 28)),
        Text("😊", style: TextStyle(fontSize: 28)),
      ],
    );
  }

  // ---------------- FOCUS CARD ----------------
  Widget _focusCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Your Focus Today",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const Text(
            "Based on your goals, here's what we recommend",
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              _focusItem("Reduce anxiety"),
              const SizedBox(width: 12),
              _focusItem("Mindfulness"),
            ],
          )
        ],
      ),
    );
  }

  Widget _focusItem(String text) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(text),
      ),
    );
  }

  // ---------------- MOTIVATION ----------------
  Widget _motivationSection() {
    return Row(
      children: [
        // Image card
        Container(
          height: 140,
          width: 140,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            image: const DecorationImage(
              image: NetworkImage(
                "https://images.unsplash.com/photo-1506126613408-eca07ce68773",
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 15),

        // Text + progress
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Stay Calm, Mindful & Stress free",
                style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              const Text(
                "“A calm mind is a powerful mind.”",
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Daily progress"),
                    SizedBox(height: 6),
                    Text("3-day Calm streak 🔥",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 6),
                    LinearProgressIndicator(value: 0.6),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  // ---------------- RECOMMENDED ----------------
  Widget _recommendedSession() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Recommended Session",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Container(
          height: 120,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            image: const DecorationImage(
              image: NetworkImage(
                "https://images.unsplash.com/photo-1506744038136-46273834b3fb",
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: const Text(
            "Try a 5 minute stress relief exercise",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  // ---------------- BOTTOM NAV ----------------
  Widget _bottomNav() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(
        color: Color(0xFFEAEAEA),
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          Icon(Icons.home),
          Icon(Icons.bar_chart),
          CircleAvatar(
            radius: 28,
            backgroundColor: Colors.purple,
            child: Icon(Icons.add, color: Colors.white, size: 30),
          ),
          Icon(Icons.history),
          Icon(Icons.settings),
        ],
      ),
    );
  }
}
