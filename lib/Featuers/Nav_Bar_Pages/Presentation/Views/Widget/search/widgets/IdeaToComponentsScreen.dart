import 'package:flutter/material.dart';

class IdeaToComponentsScreen extends StatefulWidget {
  const IdeaToComponentsScreen({super.key});

  @override
  State<IdeaToComponentsScreen> createState() => _IdeaToComponentsScreenState();
}

class _IdeaToComponentsScreenState extends State<IdeaToComponentsScreen> {
  final TextEditingController _ideaController = TextEditingController();
  final List<Map<String, String>> _chatMessages = [];

  void _fetchAIResponse() {
    final userInput = _ideaController.text.trim();
    if (userInput.isEmpty) return;

    setState(() {
      _chatMessages.add({"sender": "user", "message": userInput});
      _ideaController.clear();
      _chatMessages
          .add({"sender": "ai", "message": "AI is processing your request..."});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _ideaController,
            decoration: InputDecoration(
              hintText: "Describe your project idea...",
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                icon: const Icon(Icons.send, color: Colors.blue),
                onPressed: _fetchAIResponse,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: _chatMessages.length,
              itemBuilder: (context, index) {
                final message = _chatMessages[index];
                final isUser = message["sender"] == "user";

                return Align(
                  alignment:
                      isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.blue : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      message["message"]!,
                      style: TextStyle(
                        fontSize: 16,
                        color: isUser ? Colors.white : Colors.black87,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
