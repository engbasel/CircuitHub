import 'package:flutter/material.dart';
import 'package:store/services/DioServiceHelper.dart';

class IdeaToComponentsScreen extends StatefulWidget {
  const IdeaToComponentsScreen({super.key});

  @override
  State<IdeaToComponentsScreen> createState() => _IdeaToComponentsScreenState();
}

class _IdeaToComponentsScreenState extends State<IdeaToComponentsScreen> {
  final TextEditingController _ideaController = TextEditingController();
  final List<Map<String, String>> _chatMessages = [];
  final ApiService _apiService = ApiService();

  void _fetchAIResponse() async {
    final userInput = _ideaController.text.trim();
    if (userInput.isEmpty) return;

    setState(() {
      _chatMessages.add({"sender": "user", "message": userInput});
      _chatMessages
          .add({"sender": "ai", "message": "Processing your request..."});
    });

    List<Map<String, dynamic>> projects =
        await _apiService.searchProject(projectDescription: userInput);

    setState(() {
      _chatMessages.removeLast();
      if (projects.isEmpty) {
        _chatMessages
            .add({"sender": "ai", "message": "No similar projects found."});
      } else {
        for (var project in projects) {
          _chatMessages.add({
            "sender": "ai",
            "message":
                "🛠️ Project: ${project['project_description']}\n🔩 Components: ${project['required_components']}\n📊 Similarity Score: ${project['similarity_score']}%"
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
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
                      margin: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 8),
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
      ),
    );
  }
}
