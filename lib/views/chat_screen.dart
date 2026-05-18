import 'package:flutter/material.dart';
import '../core/constants.dart';
import '../controllers/chat_controller.dart';
import 'widgets/chat_bubble.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  // Initialize the controller
  final ChatController _chatController = ChatController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppConstants.surfaceColor,
        elevation: 4,
        title: Row(
          children: [
            Icon(Icons.smart_toy, color: AppConstants.primaryColor),
            const SizedBox(width: 10),
            Text(
              AppConstants.appName,
              style: TextStyle(color: AppConstants.textColor, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          // Indicator to show if it's connected/online (visual flair only for now)
          Container(
             margin: const EdgeInsets.only(right: 16),
             width: 12,
             height: 12,
             decoration: BoxDecoration(
               color: Colors.greenAccent,
               shape: BoxShape.circle,
               boxShadow: [BoxShadow(color: Colors.greenAccent.withOpacity(0.5), blurRadius: 5)]
             ),
          )
        ],
      ),
      // We use AnimatedBuilder to listen to the controller's notifyListeners() calls
      body: AnimatedBuilder(
        animation: _chatController,
        builder: (context, child) {
          return Column(
            children: [
              // Message List
              Expanded(
                child: ListView.builder(
                  // Reverse makes the list start from the bottom (standard chat behavior)
                  reverse: true,
                  padding: const EdgeInsets.only(top: 20, bottom: 10),
                  itemCount: _chatController.messages.length,
                  itemBuilder: (context, index) {
                    final message = _chatController.messages[index];
                    return ChatBubble(message: message);
                  },
                ),
              ),
              
              // Loading Indicator
              if (_chatController.isLoading)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(width: 20),
                      SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2, color: AppConstants.primaryColor)
                      ),
                      const SizedBox(width: 10),
                      Text("Aether is thinking...", style: TextStyle(color: AppConstants.textColor.withOpacity(0.6), fontStyle: FontStyle.italic))
                    ],
                  ),
                ),

              // Input Area
              _buildInputArea(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: AppConstants.surfaceColor,
        boxShadow: [BoxShadow(offset: const Offset(0,-2), blurRadius: 5, color: Colors.black12)]
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              style: TextStyle(color: AppConstants.textColor),
              decoration: InputDecoration(
                hintText: 'Ask Aether something...',
                hintStyle: TextStyle(color: AppConstants.textColor.withOpacity(0.5)),
                filled: true,
                fillColor: AppConstants.backgroundColor,
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: AppConstants.primaryColor.withOpacity(0.5), width: 1),
                ),
              ),
              textCapitalization: TextCapitalization.sentences,
              onSubmitted: (_) => _handleSend(),
            ),
          ),
          const SizedBox(width: 8),
          FloatingActionButton(
            onPressed: _handleSend,
            backgroundColor: AppConstants.primaryColor,
            elevation: 2,
            mini: true,
            child: const Icon(Icons.send, color: Colors.black87, size: 20),
          ),
        ],
      ),
    );
  }

  void _handleSend() {
    if (_textController.text.trim().isNotEmpty) {
      // Call the controller to handle the logic
      _chatController.sendMessage(_textController.text);
      // Clear input field
      _textController.clear();
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    _chatController.dispose();
    super.dispose();
  }
}