import 'package:flutter/material.dart';
import 'package:store/Featuers/Chat/presentation/views/buildAppBar.dart';
import 'package:store/Featuers/Nav_Bar_Pages/Presentation/Views/Widget/search/widgets/ComponentsToProjectsScreen.dart';
import 'package:store/Featuers/Nav_Bar_Pages/Presentation/Views/Widget/search/widgets/IdeaToComponentsScreen.dart';
import 'package:store/Featuers/Nav_Bar_Pages/Presentation/Views/Widget/search/widgets/buildTabBar.dart';

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
      appBar: buildAppBar(context, () {}),
      body: Column(
        children: [
          buildTabBar(_tabController),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                IdeaToComponentsScreen(),
                ComponentsToProjectsScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
