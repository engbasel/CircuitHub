import 'dart:developer';

import 'package:dash_chat_2/dash_chat_2.dart' show ChatMessage, ChatUser;
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart' as intl;
import 'package:store/Core/Utils/app_colors.dart';
import 'package:store/Core/Utils/assets.dart';

class ChatBotViewBody extends StatefulWidget {
  const ChatBotViewBody({super.key});
  static const routeName = 'ChatBotViewBody';

  @override
  ChatBotViewBodyState createState() => ChatBotViewBodyState();
}

class ChatBotViewBodyState extends State<ChatBotViewBody> {
  // Controllers
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late ChatController _chatController;

  // Chat Data
  final List<ChatMessage> _messages = [];
  ChatUser? _currentUser;
  Gemini? gemini;

  final ChatUser _botUser = ChatUser(
    id: "Dono-r",
    firstName: "Dono-r",
    profileImage: "assets/images/pnglogo.png",
  );

  @override
  void initState() {
    super.initState();
    log('ChatBotViewBody: Initializing');
    _chatController = ChatController();
    _initializeGemini();
    _fetchCurrentUser();
  }

  //------------- INITIALIZATION METHODS -------------//

  void _initializeGemini() {
    log('ChatBotViewBody: Initializing Gemini');
    try {
      Gemini.init(
        apiKey: 'AIzaSyCqi4rPy0fcnleI0_nDUMVLAhktr03edFc',
        enableDebugging: true,
      );
      gemini = Gemini.instance;
      log('ChatBotViewBody: Gemini initialized successfully');
    } catch (e) {
      log('ChatBotViewBody: Error initializing Gemini: $e');
    }
  }

  void _fetchCurrentUser() {
    // Simulate fetching current user
    setState(() {
      _currentUser = ChatUser(
        id: "user123",
        firstName: "You",
        profileImage: "assets/images/default-avatar.png",
      );
    });
  }

  //------------- MESSAGING METHODS -------------//

  void _sendMessage(String text) async {
    log('ChatBotViewBody: Sending message: "$text"');
    if (text.trim().isEmpty) {
      log('ChatBotViewBody: Message is empty, not sending');
      return;
    }

    if (_currentUser == null) {
      log('ChatBotViewBody: Current user is null, cannot send message');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Failed to send message: User not authenticated"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      final userMessage = ChatMessage(
        user: _currentUser!,
        createdAt: DateTime.now(),
        text: text,
      );

      setState(() {
        _messages.add(userMessage);
        _messageController.clear();
      });

      log('ChatBotViewBody: User message added to UI');
      _scrollToBottom();

      log('ChatBotViewBody: Sending request to Gemini');

      // Show bot is typing indicator
      setState(() {
        _messages.add(ChatMessage(
            user: _botUser,
            createdAt: DateTime.now(),
            text: "Typing...",
            customProperties: {"isTyping": true}));
      });
      _scrollToBottom();

      try {
        final response = await gemini?.chat([
          Content(parts: [Part.text(text)], role: 'user'),
        ]);

        // Remove typing indicator
        setState(() {
          _messages.removeWhere((msg) =>
              msg.user.id == _botUser.id &&
              msg.customProperties != null &&
              msg.customProperties!["isTyping"] == true);
        });

        if (response == null || response.output == null) {
          log('ChatBotViewBody: Empty response from Gemini');
          _handleBotResponse(
              "Sorry, I couldn't generate a response. Please try again.");
          return;
        }

        log('ChatBotViewBody: Received response from Gemini: "${response.output}"');
        _handleBotResponse(response.output ?? "No response from Gemini");
      } catch (e) {
        log("ChatBotViewBody: Error communicating with Gemini: $e");

        // Remove typing indicator
        setState(() {
          _messages.removeWhere((msg) =>
              msg.user.id == _botUser.id &&
              msg.customProperties != null &&
              msg.customProperties!["isTyping"] == true);
        });

        _handleBotResponse(
            "Sorry, something went wrong. Please try again later.");
      }
    } catch (e) {
      log("ChatBotViewBody: Error in _sendMessage: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error sending message: $e"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _handleBotResponse(String responseText) async {
    log('ChatBotViewBody: Handling bot response');
    final chatGPTMessage = ChatMessage(
      user: _botUser,
      createdAt: DateTime.now(),
      text: responseText,
    );

    setState(() {
      _messages.add(chatGPTMessage);
    });

    _scrollToBottom();
  }

  void _scrollToBottom() {
    log('ChatBotViewBody: Scrolling to bottom of chat');
    // Add a small delay to ensure the list is updated
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  //------------- UI BUILDING METHODS -------------//

  Widget _buildMessage(ChatMessage message) {
    final isCurrentUser = message.user.id == _currentUser?.id;
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
          log("ChatBotViewBody: Error loading avatar image: $exception");
          // Fallback in case of error
        },
      );
    } catch (e) {
      log("ChatBotViewBody: Error building avatar: $e");
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

  Widget _buildMessageInput() {
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
              controller: _messageController,
              decoration: InputDecoration(
                hintText: "Type a message...",
                hintStyle: TextStyle(color: Colors.grey.shade600),
                border: InputBorder.none,
              ),
              onFieldSubmitted: (value) {
                if (value.trim().isNotEmpty) {
                  _sendMessage(value);
                }
              },
            ),
          ),
          IconButton(
            onPressed: () => _sendMessage(_messageController.text),
            icon: const Icon(Icons.send_sharp),
            color: AppColors.darkPrimary,
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.darkPrimary,
      title: const Text(
        "Chat Bot",
      ),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'new_chat') {
              setState(() {
                _messages.clear();
              });
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'new_chat',
              child: Row(
                children: [
                  Icon(
                    Icons.add,
                    color: AppColors.darkPrimary,
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Start New Chat",
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.darkPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ],
          icon: const Icon(
            Icons.more_vert,
            color: Colors.white,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 4,
          color: Colors.white,
        ),
      ],
    );
  }

  @override
  void dispose() {
    log('ChatBotViewBody: Disposing resources');
    _scrollController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      backgroundColor: Colors.white,
      body: Directionality(
        textDirection: TextDirection.ltr,
        child: Stack(
          children: [
            // Background Watermark
            Positioned.fill(
              child: Opacity(
                opacity: 0.2,
                child: Center(
                  child: SvgPicture.asset(
                    Assets.admin_imagesCategoriesBookImg,
                    colorFilter: ColorFilter.mode(
                      AppColors.darkPrimary.withValues(alpha: 0.5),
                      BlendMode.modulate,
                    ),
                    width: 200,
                    height: 100,
                  ),
                ),
              ),
            ),
            // Main Content
            Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(8.0),
                    itemCount: _messages.length,
                    reverse: false,
                    itemBuilder: (context, index) {
                      final message = _messages[index];
                      return _buildMessage(message);
                    },
                  ),
                ),
                _buildMessageInput(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ChatController {
  Gemini? gemini;

  ChatController() {
    log('ChatController: Initializing');
    _initializeGemini();
  }

  void _initializeGemini() {
    try {
      gemini = Gemini.instance;
      log('ChatController: Gemini instance retrieved');
    } catch (e) {
      log('ChatController: Error getting Gemini instance: $e');
    }
  }
}
