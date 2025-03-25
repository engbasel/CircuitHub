import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class AIAssistantScreen extends StatefulWidget {
  const AIAssistantScreen({super.key});

  @override
  State<AIAssistantScreen> createState() => _AIAssistantScreenState();
  static const routeName = 'AIAssistantScreen';
}

class _AIAssistantScreenState extends State<AIAssistantScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _inputController = TextEditingController();
  String? aiResponse;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _inputController.dispose();
    super.dispose();
  }

  void _fetchAIResponse() {
    setState(() {
      aiResponse = "AI is processing your request...";
    });
    // TODO: Integrate AI logic here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AI Assistant"),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(IconlyLight.activity), text: "Idea to Components"),
            Tab(
                icon: Icon(IconlyLight.category),
                text: "Components to Projects"),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _inputController,
              decoration: InputDecoration(
                hintText: _tabController.index == 0
                    ? "Describe your project idea..."
                    : "List your available components...",
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
                      child: Text("Enter a query to get AI suggestions"))
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
      ),
    );
  }
}
