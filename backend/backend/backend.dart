import 'package:http/http.dart' as http;
import 'dart:convert';

const String baseUrl = 'http://localhost:5000';


const String HARDCODED_USER_ID = 'b8a13133-8b32-4b37-a9cb-74ad18992b85'; 

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