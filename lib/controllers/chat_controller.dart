import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/chat_message.dart';
import '../services/api_service.dart';
import '../services/database_service.dart';

class ChatController extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  final DatabaseService _db = DatabaseService.instance;
  
  List<ChatMessage> _messages = [];
  bool _isLoading = false;
  String? _sessionId;

  List<ChatMessage> get messages => _messages;
  bool get isLoading => _isLoading;

  ChatController() {
    _loadPersistedData();
  }

  // LOAD EVERYTHING ON STARTUP
  Future<void> _loadPersistedData() async {
    // 1. Load Session ID or create new one if it doesn't exist
    _sessionId = await _db.getSessionId();
    if (_sessionId == null) {
      _sessionId = const Uuid().v4();
      await _db.saveSessionId(_sessionId!);
    }

    // 2. Load old messages
    _messages = await _db.getAllMessages();
    notifyListeners();
  }

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    // Create & Save User Message
    final userMsg = ChatMessage(text: text.trim(), isUser: true, timestamp: DateTime.now());
    _messages.insert(0, userMsg);
    await _db.insertMessage(userMsg); // SAVE TO DB
    
    _isLoading = true;
    notifyListeners();

    // Call n8n
    String aiResponseText = await _apiService.sendPromptToN8n(text, _sessionId!);

    // Create & Save AI Message
    final aiMsg = ChatMessage(text: aiResponseText, isUser: false, timestamp: DateTime.now());
    _messages.insert(0, aiMsg);
    await _db.insertMessage(aiMsg); // SAVE TO DB
    
    _isLoading = false;
    notifyListeners();
  }
}