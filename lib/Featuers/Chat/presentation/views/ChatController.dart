// ignore_for_file: file_names

import 'dart:developer';

import 'package:flutter_gemini/flutter_gemini.dart';

class ChatController {
  Gemini? gemini;

  ChatController() {
    _initializeGemini();
  }

  void _initializeGemini() {
    try {
      Gemini.init(
        apiKey: 'AIzaSyCqi4rPy0fcnleI0_nDUMVLAhktr03edFc',
        enableDebugging: true,
      );
      gemini = Gemini.instance;
      log('ChatController: Gemini instance retrieved');
    } catch (e) {
      log('ChatController: Error getting Gemini instance: $e');
    }
  }

  Future<Candidates?> sendMessage(String text) async {
    log('ChatController: Sending request to Gemini');
    try {
      final response = await gemini?.chat([
        Content(parts: [Part.text(text)], role: 'user'),
      ]);
      log('ChatController: Received response from Gemini');
      return response;
    } catch (e) {
      log('ChatController: Error communicating with Gemini: $e');
      return null;
    }
  }
}
