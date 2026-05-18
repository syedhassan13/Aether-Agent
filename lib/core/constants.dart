import 'package:flutter/material.dart';

class AppConstants {
  // REPLACE WITH YOUR N8N PRODUCTION WEBHOOK URL
  // Ensure it ends with your specific endpoint route (e.g., /chat)
  static const String n8nWebhookUrl = "https://syedhassanai816.app.n8n.cloud/webhook/chat";

  // App Strings
  static const String appName = "Aether Agent";

  // Colors (Futuristic Dark Theme Palette)
  static const Color primaryColor = Color(0xFF00E5FF); // Cyan accent
  static const Color backgroundColor = Color(0xFF121212); // Deep dark background
  static const Color surfaceColor = Color(0xFF1E1E1E); // Slightly lighter for cards
  static const Color userBubbleColor = Color(0xFF2C2C2C); // Dark grey for user
  static const Color aiBubbleColor = Color(0xFF005F6B); // Dark cyan for AI
  static const Color textColor = Color(0xFFE0E0E0); // Off-white text
}