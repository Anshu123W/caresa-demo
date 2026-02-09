// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'dart:async';
// import 'package:firstproduction_pro/navigation/routes.dart';
// import 'package:firstproduction_pro/widgets/complaint_stepper.dart';


// class EmployeeTrackingScreen extends StatefulWidget {
//   const EmployeeTrackingScreen({super.key});

//   @override
//   State<EmployeeTrackingScreen> createState() => _EmployeeTrackingScreenState();
// }

// class _EmployeeTrackingScreenState extends State<EmployeeTrackingScreen> {
//   String status = 'submitted'; 
//   bool isLoading = true;
//   Timer? timer;

//   @override
//   void initState() {
//     super.initState();
//     _fetchInitialStatus();
//     // Start polling
//     timer = Timer.periodic(const Duration(seconds: 5), (_) => fetchStatus());
//   }

//   Future<void> _fetchInitialStatus() async {
//     await fetchStatus();
//     if (mounted) setState(() => isLoading = false);
//   }

//   Future<void> fetchStatus() async {
//     try {
//       final res = await http.get(Uri.parse('http://10.0.2.2:5000/status'))
//           .timeout(const Duration(seconds: 3)); // Add timeout to prevent hanging

//       if (res.statusCode == 200) {
//         final data = jsonDecode(res.body);
//         final newStatus = data['status'];
        
//         if (mounted && newStatus != status) {
//           setState(() => status = newStatus);
//         }
//       }
//     } catch (e) {
//       debugPrint('Polling error: $e');
//       // If the server is down, you might want to set a default status for testing:
//       // setState(() => status = 'investigation'); 
//     }
//   }

//   @override
//   void dispose() {
//     timer?.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // DEVELOPMENT TIP: Change this to 'true' if you want to test navigation 
//     // without waiting for the backend to change status.
//     final bool canContinue = status == 'resolved' || status == 'investigation';

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: const Text(
//           'Complaint Tracking',
//           style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900, fontSize: 22),
//         ),
//       ),
//       body: isLoading 
//         ? const Center(child: CircularProgressIndicator(color: Colors.black))
//         : Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Case ID: POSH-2026-1234',
//                   style: TextStyle(color: Colors.grey.shade600, fontWeight: FontWeight.w600, fontSize: 14),
//                 ),
//                 const SizedBox(height: 30),

//                 ComplaintStepper(currentStatus: status),

//                 const SizedBox(height: 40),
//                 const Text('Messages & Updates', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18)),
//                 const SizedBox(height: 16),

//                 Container(
//                   width: double.infinity,
//                   padding: const EdgeInsets.all(18),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     border: Border.all(color: Colors.black, width: 1.5),
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   child: Text(
//                     _getMessage(status),
//                     style: const TextStyle(fontSize: 15, height: 1.4, color: Colors.black, fontWeight: FontWeight.w500),
//                   ),
//                 ),

//                 const Spacer(),

//                 // NAVIGATION BUTTON
//                 SizedBox(
//                   width: double.infinity,
//                   height: 60,
//                   child: ElevatedButton(
//                     // Logic: If canContinue is false, the button is NULL (disabled)
//                     onPressed: canContinue ? () {
//                       print("Navigating to Help Screen...");
//                       Navigator.pushNamed(context, Routes.help1);
//                     } : null, 
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.black,
//                       // Style for when the button is disabled
//                       disabledBackgroundColor: Colors.grey.shade300, 
//                       foregroundColor: Colors.white,
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//                     ),
//                     child: Text(
//                       status == 'resolved' ? 'Finish' : 'Continue',
//                       style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//               ],
//             ),
//           ),
//     );
//   }

//   String _getMessage(String status) {
//     switch (status) {
//       case 'review': return 'IC Coordinator : Your report (Ref: POSH-260203) has been received. Our team is reviewing the details.';
//       case 'investigation': return 'System Update: Investigation phase initiated. An IC member will contact you shortly.';
//       case 'resolved': return 'System : Your complaint has been successfully resolved.';
//       default: return 'System : Your complaint has been successfully submitted.';
//     }
//   }
// }