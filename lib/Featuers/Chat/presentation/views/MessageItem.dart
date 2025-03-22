// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:dash_chat_2/dash_chat_2.dart' show ChatMessage, ChatUser;
import 'dart:developer';
import 'package:dash_chat_2/dash_chat_2.dart';

class MessageItem extends StatelessWidget {
  final ChatMessage message;
  final ChatUser? currentUser;
  final ChatUser botUser;

  const MessageItem({
    super.key,
    required this.message,
    required this.currentUser,
    required this.botUser,
  });

  @override
  Widget build(BuildContext context) {
    final isCurrentUser = message.user.id == currentUser?.id;
    final isTyping = message.customProperties != null &&
        message.customProperties!["isTyping"] == true;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment:
            isCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isCurrentUser) _buildAvatar(message, false),
          Expanded(
            child: Padding(
              padding: isCurrentUser
                  ? const EdgeInsets.only(right: 4)
                  : const EdgeInsets.only(left: 4),
              child: Column(
                crossAxisAlignment: isCurrentUser
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color:
                          isCurrentUser ? Colors.blue[100] : Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: isTyping
                        ? _buildTypingIndicator()
                        : Text(
                            message.text,
                            style: const TextStyle(fontSize: 14),
                          ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    intl.DateFormat('hh:mm a').format(message.createdAt),
                    style: const TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
          if (isCurrentUser) _buildAvatar(message, true),
        ],
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text("Typing"),
        const SizedBox(width: 8),
        ...List.generate(3, (index) {
          return Container(
            margin: const EdgeInsets.only(left: 2),
            child: const CircleAvatar(
              backgroundColor: Colors.grey,
              radius: 3,
            ),
          );
        }),
      ],
    );
  }

  Widget _buildAvatar(ChatMessage message, bool isCurrentUser) {
    try {
      return CircleAvatar(
        backgroundImage:
            isCurrentUser && message.user.profileImage!.startsWith('http')
                ? NetworkImage(message.user.profileImage!)
                : AssetImage(message.user.profileImage!) as ImageProvider,
        radius: 20,
        onBackgroundImageError: (exception, stackTrace) {
          log("MessageItem: Error loading avatar image: $exception");
        },
      );
    } catch (e) {
      log("MessageItem: Error building avatar: $e");
      return CircleAvatar(
        backgroundColor: isCurrentUser ? Colors.blue : Colors.grey,
        radius: 20,
        child: Text(
          message.user.firstName?.substring(0, 1) ?? "?",
          style: const TextStyle(color: Colors.white),
        ),
      );
    }
  }
}
