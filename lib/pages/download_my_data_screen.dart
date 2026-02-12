import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class DownloadMyDataScreen extends StatefulWidget {
  const DownloadMyDataScreen({super.key});

  @override
  State<DownloadMyDataScreen> createState() =>
      _DownloadMyDataScreenState();
}

class _DownloadMyDataScreenState
    extends State<DownloadMyDataScreen> {

  bool _isLoading = false;

  Future<void> _downloadData() async {
    setState(() => _isLoading = true);

    try {
      final response = await http.get(
        Uri.parse("http://10.0.2.2:5000/api/user/download-data"),
      );

      if (response.statusCode == 200) {
        final directory =
            await getApplicationDocumentsDirectory();

        final file = File(
            "${directory.path}/user_data.json");

        await file.writeAsBytes(response.bodyBytes);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text("File saved at: ${file.path}")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("Download failed")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content:
                Text("Unable to connect to server")),
      );
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [

              /// Top Bar
              SizedBox(
                height: 50,
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                          Icons.arrow_back_ios_new,
                          size: 20),
                      onPressed: () =>
                          Navigator.pop(context),
                    ),
                    const Expanded(
                      child: Center(
                        child: Text(
                          "Download My Data",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight:
                                FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 40)
                  ],
                ),
              ),

              const SizedBox(height: 30),

              Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: const [
                  Icon(Icons.shield_outlined,
                      size: 24),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "Request a copy of your personal data.",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight:
                            FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              const Text(
                "We will generate a secure file containing your profile information, "
                "activity history, and wellness journey.",
                style: TextStyle(
                  fontSize: 12.5,
                  height: 1.4,
                ),
              ),

              const SizedBox(height: 25),

              /// Request Button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed:
                      _isLoading ? null : _downloadData,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isLoading
                        ? const Color(0xFFD9D9D9)
                        : Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(28),
                    ),
                    elevation: 0,
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        )
                      : const Text(
                          "Request Data Archive",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),

              const Spacer(),

              const Center(
                child: Text(
                  "Your data is encrypted and handled according to our Privacy Policy.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 10.5,
                    color: Colors.black45,
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
