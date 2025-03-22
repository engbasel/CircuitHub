import 'package:flutter/material.dart';
import 'package:store/Core/Utils/app_colors.dart';

class MessageInput extends StatelessWidget {
  final TextEditingController messageController;
  final Function(String) onSend;

  const MessageInput({
    super.key,
    required this.messageController,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(25),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      margin: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: messageController,
              decoration: InputDecoration(
                hintText: "Type a message...",
                hintStyle: TextStyle(color: Colors.grey.shade600),
                border: InputBorder.none,
              ),
              onFieldSubmitted: (value) {
                if (value.trim().isNotEmpty) {
                  onSend(value);
                }
              },
            ),
          ),
          IconButton(
            onPressed: () => onSend(messageController.text),
            icon: const Icon(Icons.send_sharp),
            color: AppColors.darkPrimary,
          ),
        ],
      ),
    );
  }
}
