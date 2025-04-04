// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AIAssistant extends StatefulWidget {
  const AIAssistant({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AIAssistantState createState() => _AIAssistantState();

  static const routeName = 'AIAssistant';
}

class _AIAssistantState extends State<AIAssistant> {
  final TextEditingController _queryController = TextEditingController();
  final List<Map<String, String>> _chatMessages = [];

  void _sendMessage() {
    if (_queryController.text.isNotEmpty) {
      setState(() {
        _chatMessages.add({"user": _queryController.text});
        _chatMessages.add({
          "ai": "Analyzing your project needs..."
        }); // Placeholder AI response
      });
      _queryController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "AI Engineering Assistant",
          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue.shade700,
      ),
      body: Column(
        children: [
          // Chat Messages
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: _chatMessages.length,
              itemBuilder: (context, index) {
                final message = _chatMessages[index];
                final isUser = message.containsKey("user");
                return Align(
                  alignment:
                      isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color:
                          isUser ? Colors.blue.shade700 : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      message.values.first,
                      style: GoogleFonts.poppins(
                        color: isUser ? Colors.white : Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Suggested Queries
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                _suggestionButton("Recommend Tools"),
                _suggestionButton("System Design Help"),
                _suggestionButton("Project Steps Guide"),
                _suggestionButton("Find Components"),
              ],
            ),
          ),

          // Input Field
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _queryController,
                    decoration: InputDecoration(
                      hintText: "Ask AI about your project...",
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                FloatingActionButton(
                  onPressed: _sendMessage,
                  backgroundColor: Colors.blue.shade700,
                  child: const Icon(Icons.send, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _suggestionButton(String text) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _chatMessages.add({"user": text});
          _chatMessages.add(
              {"ai": "Analyzing request: $text..."}); // Placeholder AI response
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue.shade100,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: Text(text,
          style:
              GoogleFonts.poppins(fontSize: 14, color: Colors.blue.shade900)),
    );
  }
}
