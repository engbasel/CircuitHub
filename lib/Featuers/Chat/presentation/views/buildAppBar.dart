import 'package:flutter/material.dart';
import 'package:store/Core/Utils/app_colors.dart';

AppBar buildAppBar(BuildContext context, VoidCallback onNewChat) {
  return AppBar(
    backgroundColor: AppColors.darkPrimary,
    title: const Text(
      "Chat Bot",
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    centerTitle: true,
    elevation: 4,
    shadowColor: Colors.white,
    leading: Padding(
      padding: const EdgeInsets.all(8.0),
      child: CircleAvatar(
        backgroundColor: Colors.white.withOpacity(0.2),
        child: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
    ),
    actions: [
      _buildPopupMenu(onNewChat),
    ],
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(20),
      ),
    ),
  );
}

Widget _buildPopupMenu(VoidCallback onNewChat) {
  return PopupMenuButton<String>(
    onSelected: (value) {
      if (value == 'new_chat') {
        onNewChat();
      }
    },
    itemBuilder: (context) => [
      PopupMenuItem(
        value: 'new_chat',
        child: Row(
          children: [
            const Icon(Icons.add, color: Colors.blueAccent),
            const SizedBox(width: 10),
            Text(
              "Start New Chat",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey[800],
              ),
            ),
          ],
        ),
      ),
    ],
    icon: const Icon(Icons.more_vert, color: Colors.white),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    elevation: 6,
    color: Colors.white,
  );
}
