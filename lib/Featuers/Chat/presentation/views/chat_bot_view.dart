// Add this import at the top
import 'package:dash_chat_2/dash_chat_2.dart' show ChatMessage, ChatUser;
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_svg/svg.dart';
import 'package:store/Core/Utils/app_colors.dart';
import 'package:store/Core/Utils/assets.dart';
import 'package:store/Featuers/Chat/presentation/views/ChatController.dart';
import 'package:store/Featuers/Chat/presentation/views/MessageInput.dart';
import 'package:store/Featuers/Chat/presentation/views/MessageItem.dart';

class ChatBotView extends StatefulWidget {
  const ChatBotView({super.key});
  static const routeName = 'ChatBotViewBody';

  @override
  ChatBotViewState createState() => ChatBotViewState();
}

class ChatBotViewState extends State<ChatBotView> {
  // Controllers
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late ChatController _chatController;

  // Chat Data
  final List<ChatMessage> _messages = [];
  ChatUser? _currentUser;

  final ChatUser _botUser = ChatUser(
    id: "Dono-r",
    firstName: "Dono-r",
    profileImage: "assets/images/pnglogo.png",
  );

  @override
  void initState() {
    super.initState();
    _chatController = ChatController();
    _fetchCurrentUser();
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

  void _sendMessage(String text) async {
    if (text.trim().isEmpty) return;
    if (_currentUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Failed to send message: User not authenticated"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final userMessage = ChatMessage(
      user: _currentUser!,
      createdAt: DateTime.now(),
      text: text,
    );

    setState(() {
      _messages.add(userMessage);
      _messageController.clear();
    });
    _scrollToBottom();

    // Check if the message is related to electronics and electronic circuits
    if (!_isElectronicsRelated(text)) {
      _handleBotResponse(
          "sorry, I am dedicated to helping with electronic tasks only.");
      return;
    }

    setState(() {
      _messages.add(ChatMessage(
        user: _botUser,
        createdAt: DateTime.now(),
        text: "Typing...",
        customProperties: {"isTyping": true},
      ));
    });
    _scrollToBottom();

    try {
      final response = await _chatController.sendMessage(text);
      setState(() {
        _messages.removeWhere((msg) =>
            msg.user.id == _botUser.id &&
            msg.customProperties != null &&
            msg.customProperties!["isTyping"] == true);
      });

      if (response == null || response.output == null) {
        _handleBotResponse(
            "Sorry, I couldn't generate a response. Please try again.");
        return;
      }

      _handleBotResponse(response.output ?? "No response from Gemini");
    } catch (e) {
      setState(() {
        _messages.removeWhere((msg) =>
            msg.user.id == _botUser.id &&
            msg.customProperties != null &&
            msg.customProperties!["isTyping"] == true);
      });
      _handleBotResponse(
          "Sorry, something went wrong. Please try again later.");
    }
  }

  // bool _isElectronicsRelated(String text) {
  //   // Add your logic here to determine if the text is related to electronics and electronic circuits
  //   // This can be done using keyword matching, a machine learning model, or any other method
  //   // For simplicity, this example will use keyword matching
  //   final electronicsKeywords = [
  //     "electronics",
  //     "circuit",
  //     "resistor",
  //     "capacitor",
  //     "transistor",
  //     "diode",
  //     "IC",
  //     "PCB",
  //     "schematic"
  //   ];

  //   for (var keyword in electronicsKeywords) {
  //     if (text.toLowerCase().contains(keyword)) {
  //       return true;
  //     }
  //   }
  //   return false;
  // }

  bool _isElectronicsRelated(String text) {
    if (text.trim().isEmpty) return false; // Prevents unnecessary processing

    final Set<String> electronicsKeywords = {
      // Basic Components
      "electronics", "circuit", "resistor", "resistors",
      "capacitor", "capacitors", "transistor", "transistors",
      "diode", "diodes", "led", "leds", "op-amp",
      "operational amplifier", "inductor", "inductors",
      "relay", "relays", "mosfet", "bjt", "thyristor",
      "fuse", "crystal oscillator", "voltage regulator",

      // Integrated Circuits
      "IC", "ICs", "integrated circuit", "microcontroller",
      "microcontrollers", "microprocessor", "microprocessors",
      "timer IC", "555 timer", "optoisolator", "opto-isolator",

      // Power & Batteries
      "power supply", "dc-dc converter", "ac-dc converter",
      "voltage divider", "transformer", "rectifier", "battery",
      "batteries", "solar panel", "charge controller",

      // Circuit Design & PCB
      "schematic", "pcb", "pcbs", "breadboard", "veroboard",
      "soldering", "soldering iron", "flux", "multimeter",
      "oscilloscope", "logic analyzer", "waveform generator",
      "circuit board", "etching", "silkscreen", "smt", "through-hole",
      "surface mount", "ground plane", "circuit simulation",
      "SPICE simulation", "proteus", "eagle", "kicad",

      // Sensors & IoT
      "sensor", "sensors", "temperature sensor", "humidity sensor",
      "motion sensor", "infrared sensor", "ultrasonic sensor",
      "gyroscope", "accelerometer", "pressure sensor",
      "hall effect sensor", "current sensor", "voltage sensor",
      "RFID", "NFC", "ESP32", "ESP8266", "WiFi module",
      "Bluetooth module", "zigbee", "LoRa", "IoT", "Internet of Things",

      // Communication & Signal Processing
      "UART", "SPI", "I2C", "CAN bus", "modulation",
      "demodulation", "amplifier", "signal processor",
      "low-pass filter", "high-pass filter", "band-pass filter",

      // Embedded Systems & Development Boards
      "Arduino", "Raspberry Pi", "STM32", "PIC microcontroller",
      "Atmega", "MSP430", "BeagleBone",
      "development board", "DIY electronics",

      // Connectors & Wiring
      "connector", "connectors", "header pins",
      "jumper wires", "ribbon cable", "terminal block",
      "banana plug", "usb connector", "hdmi connector",
      "ethernet", "rf connector", "coaxial cable",

      // Measuring & Testing
      "ammeter", "voltmeter", "ohmmeter",
      "LCR meter", "frequency counter", "logic probe",
      "power meter", "spectrum analyzer",

      // Brands & IC Series
      "Texas Instruments",
      "STMicroelectronics", "Atmel", "Microchip",
      "Analog Devices", "Fairchild Semiconductor",
      "Infineon", "ON Semiconductor", "NXP",
    };

    return electronicsKeywords
        .any((keyword) => text.toLowerCase().contains(keyword.toLowerCase()));
  }

  void _handleBotResponse(String responseText) {
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

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.darkPrimary,
      title: const Text("Chat Bot"),
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
                  Icon(Icons.add, color: AppColors.darkPrimary),
                  SizedBox(width: 10),
                  Text(
                    "Start New Chat",
                    style:
                        TextStyle(fontSize: 16, color: AppColors.darkPrimary),
                  ),
                ],
              ),
            ),
          ],
          icon: const Icon(Icons.more_vert, color: Colors.white),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 4,
          color: Colors.white,
        ),
      ],
    );
  }

  @override
  void dispose() {
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
            Positioned.fill(
              child: Opacity(
                opacity: 0.2,
                child: Center(
                  child: SvgPicture.asset(
                    Assets.admin_imagesCategoriesBookImg,
                    colorFilter: ColorFilter.mode(
                      AppColors.darkPrimary.withOpacity(0.5),
                      BlendMode.modulate,
                    ),
                    width: 200,
                    height: 100,
                  ),
                ),
              ),
            ),
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
                      return MessageItem(
                        message: message,
                        currentUser: _currentUser,
                        botUser: _botUser,
                      );
                    },
                  ),
                ),
                MessageInput(
                  messageController: _messageController,
                  onSend: _sendMessage,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
