import 'package:http/http.dart' as http;
import 'dart:convert';

const String baseUrl = 'http://localhost:5000';
const String HARDCODED_USER_ID = 'b8a13133-8b32-4b37-a9cb-74ad18992b85'; 
Future<Map<String, dynamic>> sendComplaint({
  required bool isAnonymous,
  String? name,
  required String category,
  required String description,
  required String complaintDate,
  required String complaintTime,
  required String location,
}) async {
  final urlforcomplaints= Uri.parse('http://localhost:5000/complaint');

  final body = jsonEncode({
    'userId': HARDCODED_USER_ID,
    'is_anonymous': isAnonymous,
    'name': isAnonymous ? null : name,
    'category': category,
    'description': description,
    'complaint_date': complaintDate,
    'complaint_time': complaintTime,
    'location': location,
  });

  try {
    final response = await http.post(
      urlforcomplaints,
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      print('Complaint saved: ${data['complaint_id']}');
      return {'success': true, 'complaintId': data['complaint_id']};
    } else {
      final error = jsonDecode(response.body);
      print('Failed: ${error['error']}');
      return {'success': false, 'error': error['error']};
    }
  } catch (e) {
    print('Error sending complaint: $e');
    return {'success': false, 'error': e.toString()};
  }
}


Future<String?> fetchLatestComplaintId() async {
  final url = Uri.parse(
    '$baseUrl/complaint/latest/$HARDCODED_USER_ID',
  );

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      return data['complaint_id'];
    } else {
      print("Failed to fetch complaint ID");
      return null;
    }
  } catch (e) {
    print("Error fetching complaint ID: $e");
    return null;
  }
}


class BackendState {
  static String? complaintId;
}

Future<bool> sendresponse({
  required List<int> questionIds,
  required List<dynamic> answers,
  List<String>? freeTextAnswers,
}) async {
  final url = Uri.parse('$baseUrl/responses');

  final body = jsonEncode({
    'userId': HARDCODED_USER_ID,
    'questionIds': questionIds,
    'answers': answers,
    if (freeTextAnswers != null) 'freeTextAnswers': freeTextAnswers,
  });

  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    if (response.statusCode == 200) {
      print('Responses saved: ${response.body}');
      return true;
    } else {
      print('Failed to save responses: ${response.body}');
      return false;
    }
  } catch (error) {
    print('Error sending responses: $error');
    return false;
  }
}