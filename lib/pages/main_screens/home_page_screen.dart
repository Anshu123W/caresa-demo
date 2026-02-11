import 'package:firstproduction_pro/navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/* ===================== MAIN NAV ===================== */

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // Updated List to include your ExploreScreen content
  final List<Widget> _pages = const [
    HomePage(),
    ExplorePage(), 
    Center(child: Text("History")),
    Center(child: Text("Settings")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(index: _selectedIndex, children: _pages),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF9166FF),
        onPressed: () {},
        child: const Icon(Icons.add, size: 32, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _bottomBar(),
    );
  }

  Widget _bottomBar() {
    return BottomAppBar(
      height: 110,
      shape: const CircularNotchedRectangle(),
      notchMargin: 10,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _navItem(Icons.home_outlined, "Home", 0),
              _navItem(Icons.explore_outlined, "Explore", 1),
              const SizedBox(width: 48),
              _navItem(Icons.history_outlined, "History", 2),
              _navItem(Icons.settings_outlined, "Settings", 3),
            ],
          ),
          const SizedBox(height: 8),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.lock_outline, size: 14, color: Colors.grey),
              SizedBox(width: 4),
              Text(
                "Your data is private and secured",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _navItem(IconData icon, String label, int index) {
    final active = _selectedIndex == index;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => setState(() => _selectedIndex = index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: active ? Colors.black : Colors.grey),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: active ? Colors.black : Colors.grey,
              fontWeight: active ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

/* ===================== EXPLORE PAGE ===================== */

/* ===================== EXPLORE PAGE ===================== */

/* ===================== EXPLORE PAGE ===================== */

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Explore',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.search, color: Colors.black),
                  onPressed: () {
                    // Search functionality could go here
                  },
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 120),
            child: Column(
              children: [
                // 1. SWOT CARD - Clickable
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DetailScreen(title: "SWOT Journaling"),
                    ),
                  ),
                  child: _buildFeaturedCard(),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    // 2. DAILY JOURNAL - Clickable
                    Expanded(
                      child: GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DetailScreen(title: "Daily Journal"),
                          ),
                        ),
                        child: _buildSmallCard('Daily Journal', 'Write it out', Icons.edit_note),
                      ),
                    ),
                    const SizedBox(width: 15),
                    // 3. MOOD TRACKING - Clickable (using your Routes)
                    Expanded(
                      child: GestureDetector(
                        onTap: () => Navigator.pushNamed(context, Routes.assessment),
                        child: _buildSmallCard('Mood Tracking', 'Check in', Icons.sentiment_satisfied_alt),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // 4. PROGRESS CARD - Clickable
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DetailScreen(title: "POSH Module"),
                    ),
                  ),
                  child: _buildProgressCard(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ... (Keep your _buildFeaturedCard, _buildSmallCard, and _buildProgressCard methods exactly as they were)
  
  Widget _buildFeaturedCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text('FEATURED', style: TextStyle(color: Colors.white, fontSize: 10)),
          ),
          const SizedBox(height: 20),
          const Text(
            'SWOT\nJournaling',
            style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold, height: 1.1),
          ),
          const SizedBox(height: 12),
          Text(
            'Analyze your Strengths, Weaknesses, Opportunities, and Threats.',
            style: TextStyle(color: Colors.grey[400], fontSize: 14),
          ),
          const SizedBox(height: 24),
          const Row(
            children: [
              Text('Start Analysis', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
              SizedBox(width: 8),
              Icon(Icons.arrow_forward, color: Colors.white, size: 18),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildSmallCard(String title, String subtitle, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(20),
      height: 200,
      decoration: BoxDecoration(
        color: const Color(0xFFF2F2F2),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(icon, color: Colors.black),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 14)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProgressCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFEEEEEE)),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(8)),
            child: const Text('POSH', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10)),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Prevention of Sexual Harassment', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('MODULE 3 OF 5', style: TextStyle(color: Colors.grey, fontSize: 10)),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Container(height: 4, width: 40, decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(2))),
        ],
      ),
    );
  }
}

/* ===================== DETAIL SCREEN ===================== */

class DetailScreen extends StatelessWidget {
  final String title;
  const DetailScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(title, style: const TextStyle(color: Colors.black)),
      ),
      body: Center(
        child: Text(
          "Welcome to the $title page!",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
/* ===================== HOME PAGE ===================== */
// (Keep your existing HomePage, DateRow, FocusSection, etc. here)

/* ===================== HOME ===================== */

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  String _getGreeting() {
    final h = DateTime.now().hour;
    if (h < 12) return "Good Morning!";
    if (h < 17) return "Good Afternoon!";
    return "Good Evening!";
  }

  void _showCalendar(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
    );
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final topDate = DateFormat('EEE, d MMM').format(now);

    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: Row(
              children: [
                Text(
                  _getGreeting(),
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () => _showCalendar(context),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F3F3),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Text(topDate,
                            style: const TextStyle(fontSize: 12)),
                        const SizedBox(width: 6),
                        const Icon(Icons.calendar_today,
                            size: 14, color: Color(0xFF9166FF)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 140),
              child: Column(
                children: const [
                  DateRow(),
                  SizedBox(height: 24),
                  FocusSection(),
                  SizedBox(height: 24),
                  MotivationSection(),
                  SizedBox(height: 24),
                  RecommendedSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/* ===================== DATE ROW ===================== */

class DateRow extends StatelessWidget {
  const DateRow({super.key});

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final emojis = ["😍", "😟", "😊", "🙂", "😐", "🙂", "😊"];

    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: 7,
        itemBuilder: (context, index) {
          final date = today.add(Duration(days: index - 3));
          final isToday = DateUtils.isSameDay(date, today);

          return DateItem(
            day: DateFormat('EEE').format(date),
            date: DateFormat('dd').format(date),
            emoji: emojis[index],
            selected: isToday,
          );
        },
      ),
    );
  }
}

class DateItem extends StatelessWidget {
  final String day;
  final String date;
  final String emoji;
  final bool selected;

  const DateItem({
    super.key,
    required this.day,
    required this.date,
    required this.emoji,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      margin: const EdgeInsets.symmetric(horizontal: 6),
      child: Column(
        children: [
          Text(day, style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 6),
          Container(
            width: 48,
            height: 48,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: selected ? const Color(0xFF9166FF) : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Text(
              date,
              style: TextStyle(
                color: selected ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(emoji, style: const TextStyle(fontSize: 22)),
        ],
      ),
    );
  }
}

/* ===================== SECTIONS ===================== */

class FocusSection extends StatelessWidget {
  const FocusSection({super.key});

  @override
  Widget build(BuildContext context) {
    return card(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Your Focus Today",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          const Text(
            "Based on your goals, here's what we recommend",
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
          const SizedBox(height: 16),
          Row(
            children: const [
              FocusChip("Reduce anxiety"),
              SizedBox(width: 12),
              FocusChip("Mindfulness"),
            ],
          ),
        ],
      ),
    );
  }
}

class MotivationSection extends StatelessWidget {
  const MotivationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Image.asset(
              "assets/images/meditation.jpg",
              width: 160,
              height: 180,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Stay Calm, Mindful & Stress free",
                  style:
                  TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  "\"A calm mind is a powerful mind.\"",
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      fontStyle: FontStyle.italic),
                ),
                SizedBox(height: 12),
                StreakCard(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class StreakCard extends StatelessWidget {
  const StreakCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 22,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Daily progress",
                  style: TextStyle(color: Colors.grey, fontSize: 12)),
              Icon(Icons.more_horiz),
            ],
          ),
          const SizedBox(height: 6),
          const Text(
            "3-day Calm streak 🔥",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: const LinearProgressIndicator(
              value: 0.7,
              minHeight: 8,
              backgroundColor: Color(0xFFE0E0E0),
              color: Color(0xFF9E9E9E),
            ),
          ),
        ],
      ),
    );
  }
}

class RecommendedSection extends StatelessWidget {
  const RecommendedSection({super.key});

  @override
  Widget build(BuildContext context) {
    return card(
      const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Recommended Session",
              style: TextStyle(color: Colors.grey)),
          SizedBox(height: 6),
          Text("Try a 5 minute stress relief exercise",
              style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class FocusChip extends StatelessWidget {
  final String text;
  const FocusChip(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 80,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color(0xFFE5E5E5),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(text),
      ),
    );
  }
}

/* ===================== CARD ===================== */

Widget card(Widget child) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: const Color(0xFFE5E5E5),
      borderRadius: BorderRadius.circular(24),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.12),
          blurRadius: 30,
          offset: const Offset(0, 14),
        ),
        BoxShadow(
          color: Colors.black.withOpacity(0.06),
          blurRadius: 60,
          offset: const Offset(0, 30),
        ),
      ],
    ),
    child: child,
  );
}
/* ===================== DETAIL PAGE ===================== */

