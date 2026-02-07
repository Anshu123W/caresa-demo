import 'package:firstproduction_pro/backend/backend.dart';
import 'package:flutter/material.dart';
import '../navigation/routes.dart';

class M4OpenSharingScreen extends StatefulWidget {
  final int questionid_14;
  const M4OpenSharingScreen({Key? key, required this.questionid_14}) : super(key: key);

  @override
  State<M4OpenSharingScreen> createState() => _M4OpenSharingScreenState();
}

class _M4OpenSharingScreenState extends State<M4OpenSharingScreen> {
  final TextEditingController _textController = TextEditingController();
  bool _isHasText = false;

  @override
  void initState() {
    super.initState();
    _textController.addListener(() {
      setState(() {
        _isHasText = _textController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  Future<void> _handleNext() async {
    if (!_isHasText) {
      // Optional: just navigate if no text
      Navigator.pushNamed(context, Routes.insights);
      return;
    }

    final success = await sendresponse(

      questionIds: [widget.questionid_14],
      answers: [
        [0]
      ],
      freeTextAnswers: [_textController.text], // assuming backend supports this
    );

    if (success) {
      Navigator.pushNamed(context, Routes.insights);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to save response!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF2D2D2D), size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pushNamed(context, Routes.insights),
            child: const Text(
              'Skip',
              style: TextStyle(
                color: Color(0xFF9E9E9E),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              const Text(
                'Is there anything else on your mind you\'d like to share?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF2D2D2D),
                  height: 1.2,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                '(This is completely optional)',
                style: TextStyle(
                  fontSize: 15,
                  color: Color(0xFF9E9E9E),
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 32),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      )
                    ],
                  ),
                  child: TextField(
                    controller: _textController,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    textCapitalization: TextCapitalization.sentences,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF2D2D2D),
                      height: 1.5,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Type anything here... your hopes, fears, or what \'mental clarity\' means to you.',
                      hintStyle: TextStyle(
                        fontSize: 15,
                        color: const Color(0xFF2D2D2D).withOpacity(0.3),
                        fontStyle: FontStyle.italic,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.lock_outline,
                    size: 14,
                    color: const Color(0xFF9E9E9E).withOpacity(0.6),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'This is for your reflection. Our team will not read individual responses.',
                      style: TextStyle(
                        fontSize: 12,
                        color: const Color(0xFF9E9E9E).withOpacity(0.8),
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: _isHasText ? _handleNext : () => Navigator.pushNamed(context, Routes.insights),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isHasText ? Colors.black : const Color(0xFFD1D1D1),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Next',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
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
}
