import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:store/Featuers/Nav_Bar_Pages/Presentation/Views/Widget/search/AIAssistantScreen.dart';

class HelpingWidget extends StatelessWidget {
  const HelpingWidget({super.key});

  static const Duration animationDuration = Duration(seconds: 1);
  static const Color primaryColor = Colors.blue;
  static const Color textColor = Colors.black87;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildAnimatedText(
          'Need help with your project?',
          20,
          FontWeight.bold,
          primaryColor,
        ),
        const SizedBox(height: 10),
        _buildAnimatedText(
          'Ask our AI assistant for recommendations on tools, system design, and steps!',
          16,
          FontWeight.w500,
          textColor,
        ),
        const SizedBox(height: 20),
        _buildAnimatedButton(context),
      ],
    );
  }

  Widget _buildAnimatedText(
      String text, double fontSize, FontWeight fontWeight, Color color) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: 1),
      duration: animationDuration,
      curve: Curves.easeInOut,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, (1 - value) * 20),
            child: child,
          ),
        );
      },
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildAnimatedButton(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: 1),
      duration: animationDuration,
      curve: Curves.easeInOut,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.scale(
            scale: value,
            child: child,
          ),
        );
      },
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            AIAssistantEngginering.routeName,
          );
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          backgroundColor: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 5,
        ),
        child: Text(
          'Ask your AI Engineer Assistant',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
