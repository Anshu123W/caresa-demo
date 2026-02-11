import 'package:flutter/material.dart';

import 'change_password_screen.dart';
import 'download_my_data_screen.dart';
import 'delete_my_account_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

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
                  children: const [
                    BackButton(),
                    Expanded(
                      child: Center(
                        child: Text(
                          "⚙ Settings",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 40),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// ACCOUNT SECTION
              _sectionTitle(Icons.person_outline, "Account"),
              const SizedBox(height: 10),
              _cardContainer(
                children: [
                  _tile(context, "Edit Profile", Icons.edit_outlined),
                  _divider(),
                  _tile(
                    context,
                    "Change Password",
                    Icons.vpn_key_outlined,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ChangePasswordScreen(),
                        ),
                      );
                    },
                  ),
                  _divider(),
                  _tile(context, "Linked accounts", Icons.link),
                ],
              ),

              const SizedBox(height: 25),

              /// PRIVACY SECTION
              _sectionTitle(Icons.shield_outlined, "Privacy & Security"),
              const SizedBox(height: 10),
              _cardContainer(
                children: [
                  _tile(context, "Data Privacy Info", Icons.info_outline),
                  _divider(),
                  _tile(
                    context,
                    "Download My Data",
                    Icons.download_outlined,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              const DownloadMyDataScreen(),
                        ),
                      );
                    },
                  ),
                  _divider(),
                  _tile(
                    context,
                    "Delete My Account",
                    Icons.delete_outline,
                    isRed: true,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              const DeleteMyAccountScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),

              const SizedBox(height: 25),

              /// NOTIFICATIONS SECTION
              _sectionTitle(Icons.notifications_none, "Notifications"),
              const SizedBox(height: 10),
              _cardContainer(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 12),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Text(
                            "Mood Reminder Alerts",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        Switch(
                          value: false,
                          onChanged: (val) {},
                          activeColor: Colors.black,
                        )
                      ],
                    ),
                  ),
                ],
              ),

              const Spacer(),

              /// Logout
              Center(
                child: GestureDetector(
                  onTap: () {},
                  child: const Text(
                    "Log out  ›",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.red,
                      fontWeight: FontWeight.w500,
                    ),
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

  /// Section Title
  static Widget _sectionTitle(IconData icon, String title) {
    return Row(
      children: [
        Icon(icon, size: 22),
        const SizedBox(width: 10),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  /// Card Container
  static Widget _cardContainer({required List<Widget> children}) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFE9E9E9),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(children: children),
    );
  }

  /// Divider inside card
  static Widget _divider() {
    return const Divider(
      height: 1,
      thickness: 1,
      color: Colors.black12,
    );
  }

  /// Tile (Now Clickable)
  static Widget _tile(
    BuildContext context,
    String title,
    IconData icon, {
    bool isRed = false,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  color: isRed ? Colors.red : Colors.black,
                ),
              ),
            ),
            Icon(
              icon,
              size: 20,
              color: isRed ? Colors.red : Colors.black87,
            )
          ],
        ),
      ),
    );
  }
}
