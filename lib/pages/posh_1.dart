import 'package:flutter/material.dart';

class posh1 extends StatefulWidget {
  const posh1({super.key});

  @override
  State<posh1> createState() => _PoshAwarenessScreenState();
}

class _PoshAwarenessScreenState extends State<posh1> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // ================= SCROLLABLE CONTENT =================
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // TITLE
                    const Text(
                      'POSH Awareness\n& Consent',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        height: 1.25,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // DESCRIPTION
                    const Text(
                      'The Prevention of Sexual Harassment (POSH) policy ensures a safe, respectful, and inclusive workplace for everyone.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 18),

                    // POLICY CARD
                    _card(
                      child: const Text(
                        'This policy protects all\nemployees, interns and contractors.',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),

                    // EXAMPLES CARD
                    _card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Row(
                            children: [
                              Icon(Icons.description_outlined, size: 20),
                              SizedBox(width: 8),
                              Text(
                                'Examples of harassment',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          _Bullet(
                            'Unwelcome physical contact, advances, or sexually suggestive behavior.',
                          ),
                          _Bullet(
                            'Sharing offensive, explicit, or non-consensual digital content.',
                          ),
                          _Bullet(
                            'Abuse of authority or conduct that creates a hostile or intimidating environment.',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),

                    // REMEMBER
                    const Text(
                      'REMEMBER :',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),

                    const _CheckLine('Consent must be clear & voluntary'),
                    const _CheckLine('Complaints are confidential'),
                    const _CheckLine('Retaliation is prohibited'),

                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),

            // ================= FIXED FOOTER =================
            Container(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // CHECKBOX
                  CheckboxListTile(
                    value: isChecked,
                    onChanged: (value) {
                      setState(() {
                        isChecked = value ?? false;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                    title: const Text(
                      'I have read and understood the POSH policy and know my rights.',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),

                  const SizedBox(height: 8),

                  // CONTINUE BUTTON
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: isChecked ? () {} : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isChecked
                            ? Colors.grey.shade800
                            : Colors.grey.shade300,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Continue',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= CARD =================
  static Widget _card({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}

// ================= BULLET =================
class _Bullet extends StatelessWidget {
  final String text;
  const _Bullet(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(fontSize: 18)),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}

// ================= CHECK LINE =================
class _CheckLine extends StatelessWidget {
  final String text;
  const _CheckLine(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          const Icon(Icons.check_circle, size: 18),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
