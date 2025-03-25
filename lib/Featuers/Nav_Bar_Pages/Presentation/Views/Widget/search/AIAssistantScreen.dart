import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class AIAssistantEngginering extends StatefulWidget {
  const AIAssistantEngginering({super.key});
  static const routeName = 'AIAssistantScreen';

  @override
  State<AIAssistantEngginering> createState() => _AIAssistantEnggineringState();
}

class _AIAssistantEnggineringState extends State<AIAssistantEngginering>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
      body: TabBarView(
        controller: _tabController,
        children: const [
          IdeaToComponentsScreen(),
          ComponentsToProjectsScreen(),
        ],
      ),
    );
  }
}

class IdeaToComponentsScreen extends StatelessWidget {
  const IdeaToComponentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Colors.red),
        child: const Center(
          child: Text(
            'This is the Idea to Components Screen',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class ComponentsToProjectsScreen extends StatelessWidget {
  const ComponentsToProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Colors.green),
        child: const Center(
          child: Text(
            'This is the Components to Projects Screen',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
