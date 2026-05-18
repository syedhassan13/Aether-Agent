import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../core/constants.dart';

class ApiService {
  Future<String> sendPromptToN8n(String message, String sessionId) async {
    try {
      log("Attempting to connect to n8n...");
      final uri = Uri.parse(AppConstants.n8nWebhookUrl);
      
      final response = await http.post(
        uri,
        headers: {"Content-Type": "application/json"},
        // The structure your n8n Webhook expects
        body: jsonEncode({
          "message": message,
          "sessionId": sessionId,
        }),
      );

      log("Response status: ${response.statusCode}");
      log("Response body: ${response.body}");

      if (response.statusCode == 200) {
        // The structure your "Respond to Webhook" node sends back
        final data = jsonDecode(response.body);
        // Ensure the key 'reply' matches your n8n output node key
        return data['reply'] ?? "Received empty response from agent.";
      } else {
        return "Error: Unable to connect to Aether Agent (Status Code: ${response.statusCode}).";
      }
    } catch (e) {
      log("Exception caught: $e");
      return "Connection Error: Check your internet connection or the webhook URL.";
    }
  }
}