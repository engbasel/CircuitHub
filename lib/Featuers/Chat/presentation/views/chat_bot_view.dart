// Add this import at the top
import 'package:dash_chat_2/dash_chat_2.dart' show ChatMessage, ChatUser;
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:store/Core/Utils/assets.dart';
import 'package:store/Featuers/Chat/presentation/views/ChatController.dart';
import 'package:store/Featuers/Chat/presentation/views/buildAppBar.dart';

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
        profileImage: Assets.admin_imagesCategoriesMobiles,
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

  @override
  void dispose() {
    _scrollController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, () {}),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Assets.logo), // صورة خلفية ناعمة
                  fit: BoxFit.cover,
                  opacity: 0.1,
                ),
              ),
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(vertical: 10),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  final isUser = message.user.id == _currentUser?.id;

                  return Align(
                    alignment:
                        isUser ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      padding: const EdgeInsets.all(12),
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.75,
                      ),
                      decoration: BoxDecoration(
                        color: isUser ? Colors.blueAccent : Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(15),
                          topRight: const Radius.circular(15),
                          bottomLeft:
                              isUser ? const Radius.circular(15) : Radius.zero,
                          bottomRight:
                              isUser ? Radius.zero : const Radius.circular(15),
                        ),
                        boxShadow: [
                          BoxShadow(
                            // ignore: deprecated_member_use
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 5,
                            offset: const Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        message.text,
                        style: TextStyle(
                          color: isUser ? Colors.white : Colors.black87,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  // ignore: deprecated_member_use
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: "Type a message...",
                      hintStyle: TextStyle(color: Colors.grey[500]),
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Colors.grey[100],
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: const BorderSide(color: Colors.blueAccent),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () => _sendMessage(_messageController.text),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          // ignore: deprecated_member_use
                          color: Colors.blueAccent.withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(12),
                    child:
                        const Icon(Icons.send, color: Colors.white, size: 24),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
