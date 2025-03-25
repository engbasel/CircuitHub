import 'package:flutter/material.dart';

class IdeaToComponentsScreen extends StatefulWidget {
  const IdeaToComponentsScreen({super.key});

  @override
  State<IdeaToComponentsScreen> createState() => _IdeaToComponentsScreenState();
}

class _IdeaToComponentsScreenState extends State<IdeaToComponentsScreen> {
  final TextEditingController _ideaController = TextEditingController();
  String? aiResponse;

  void _fetchAIResponse() {
    setState(() {
      aiResponse = "AI is processing your request...";
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
            child: aiResponse == null
                ? const Center(
                    child: Text("Enter a project idea to get AI suggestions"))
                : Card(
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        aiResponse!,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
