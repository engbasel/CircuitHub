import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:store/Core/Utils/app_colors.dart';

Widget buildTabBar(TabController? controller) {
  return Container(
    color: AppColors.darkPrimary,
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
