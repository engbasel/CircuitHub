import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

Widget buildTabBar(TabController? controller, BuildContext context) {
  bool isDarkTheme = Theme.of(context).brightness == Brightness.dark;
  return Container(
    color: isDarkTheme ? Colors.black : Colors.white,
    child: TabBar(
      controller: controller,
      indicatorColor: Colors.white,
      labelColor: Colors.white,
      unselectedLabelColor: Colors.grey,
      tabs: const [
        Tab(icon: Icon(IconlyLight.activity), text: "Idea to Components"),
        Tab(icon: Icon(IconlyLight.category), text: "Components to Projects"),
      ],
    ),
  );
}
