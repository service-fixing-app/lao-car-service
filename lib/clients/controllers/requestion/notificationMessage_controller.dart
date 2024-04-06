// history_controller.dart

import 'dart:convert';
import 'package:http/http.dart' as http;

class HistoryController {
  static Future<List<String>> getMessages() async {
    final response = await http.get(Uri.parse('http://localhost:3000/api/messages/UserB'));
    if (response.statusCode == 200) {
      final List<dynamic> messagesJson = jsonDecode(response.body)['messages'];
      return messagesJson.map((message) => message['message'] as String).toList();
    } else {
      throw Exception('Failed to retrieve messages');
    }
  }
}
