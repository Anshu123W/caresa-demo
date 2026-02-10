import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firstproduction_pro/navigation/routes.dart';

/* ===================== MAIN NAV ===================== */

class OrganisationUserDashboardPage extends StatefulWidget {
  const OrganisationUserDashboardPage({super.key});

  @override
  State<OrganisationUserDashboardPage> createState() =>
      _OrganisationUserDashboardPageState();
}

class _OrganisationUserDashboardPageState
    extends State<OrganisationUserDashboardPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    OrganisationHomeScreen(),
    Center(child: Text("Stats")),
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
        child: const Icon(Icons.add, size: 32),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _bottomBar(context),
    );
  }

  Widget _bottomBar(BuildContext context) {
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

              // POSH button in center
           GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, Routes.posh1);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.shield_outlined, color: Colors.grey),
                    SizedBox(height: 2),
                    Text(
                      "POSH",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),


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
      onTap: () => setState(() => _selectedIndex = index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: active ? Colors.black : Colors.grey),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: active ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

/* ===================== HOME ===================== */

class OrganisationHomeScreen extends StatelessWidget {
  const OrganisationHomeScreen({super.key});

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
        children: const [
          Text("Your Focus Today",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 4),
          Text(
            "Based on your goals, here's what we recommend",
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
          SizedBox(height: 16),
          Row(
            children: [
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
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          SizedBox(width: 160, height: 180),
          SizedBox(width: 16),
          Expanded(child: StreakCard()),
        ],
      ),
    );
  }
}

class StreakCard extends StatelessWidget {
  const StreakCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text("3-day Calm streak 🔥");
  }
}

class RecommendedSection extends StatelessWidget {
  const RecommendedSection({super.key});

  @override
  Widget build(BuildContext context) {
    return card(
      const Text("Try a 5 minute stress relief exercise"),
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

Widget card(Widget child) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: const Color(0xFFE5E5E5),
      borderRadius: BorderRadius.circular(24),
    ),
    child: child,
  );
}
