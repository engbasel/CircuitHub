// ignore_for_file: file_names

import 'package:flutter/material.dart';

Widget buildPopupMenu(VoidCallback onNewChat) {
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
