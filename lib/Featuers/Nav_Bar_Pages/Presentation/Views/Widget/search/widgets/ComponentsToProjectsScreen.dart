import 'package:flutter/material.dart';

class ComponentsToProjectsScreen extends StatefulWidget {
  const ComponentsToProjectsScreen({super.key});

  @override
  State<ComponentsToProjectsScreen> createState() =>
      _ComponentsToProjectsScreenState();
}

class _ComponentsToProjectsScreenState
    extends State<ComponentsToProjectsScreen> {
  final TextEditingController _componentsController = TextEditingController();
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
            controller: _componentsController,
            decoration: InputDecoration(
              hintText: "List your available components...",
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
                    child:
                        Text("Enter components to get AI project suggestions"))
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
