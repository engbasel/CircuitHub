// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:store/Core/Utils/app_colors.dart';
import 'package:store/Featuers/Nav_Bar_Pages/Presentation/Views/Widget/search/widgets/buildPopupMenu.dart';

AppBar buildAppBar(BuildContext context, VoidCallback onNewChat) {
  return AppBar(
    backgroundColor: AppColors.darkPrimary,
    title: const Text(
      "AI Assistant",
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    centerTitle: true,
    elevation: 4,
    leading: Padding(
      padding: const EdgeInsets.all(8.0),
      child: CircleAvatar(
        // ignore: deprecated_member_use
        backgroundColor: Colors.white.withOpacity(0.2),
        child: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
    ),
    actions: [
      buildPopupMenu(onNewChat),
    ],
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(1),
      ),
    ),
  );
}
