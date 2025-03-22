import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:store/Core/Services/shared_preferences_sengleton.dart';
import 'package:store/Featuers/authUseingProvider/login.dart';
import 'package:store/constans.dart';

// Define constants for reuse with refined values
class PageViewItemConfig {
  static const double defaultImageHeightFactor = 0.35; // 35% of screen height
  static const double defaultImageWidthFactor = 0.5; // 50% of screen width
  static const double defaultBackgroundHeightFactor =
      0.45; // 45% of screen height
  static const double verticalSpacingLarge = 48.0; // Reduced for tighter layout
  static const double verticalSpacingMedium = 16.0; // More subtle spacing
  static const double verticalSpacingSmall = 8.0; // Added for finer control
  static const double horizontalPadding = 32.0; // Slightly reduced for balance
  static const double skipButtonPadding =
      12.0; // Smaller padding for skip button
}

class PageviewItem extends StatelessWidget {
  const PageviewItem({
    super.key,
    required this.image,
    required this.backgroundImage,
    required this.subtitle,
    required this.title,
    required this.isVisible,
    this.imageWidth,
    this.imageHeight,
    this.backgroundImageWidth,
    this.backgroundImageHeight,
    this.subtitleStyle,
  });

  final String image;
  final String backgroundImage;
  final String subtitle;
  final Widget title;
  final bool isVisible;
  final double? imageWidth;
  final double? imageHeight;
  final double? backgroundImageWidth;
  final double? backgroundImageHeight;
  final TextStyle? subtitleStyle;

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions using MediaQuery
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildImageSection(context, screenWidth, screenHeight),
        const SizedBox(height: PageViewItemConfig.verticalSpacingLarge),
        title,
        const SizedBox(height: PageViewItemConfig.verticalSpacingMedium),
        buildSubtitle(context),
        const SizedBox(height: PageViewItemConfig.verticalSpacingSmall),
      ],
    );
  }

  Widget _buildImageSection(
    BuildContext context,
    double screenWidth,
    double screenHeight,
  ) {
    return SizedBox(
      width: backgroundImageWidth ?? screenWidth,
      height: backgroundImageHeight ??
          screenHeight * PageViewItemConfig.defaultBackgroundHeightFactor,
      child: Stack(
        alignment: Alignment.center, // Center all children in the Stack
        children: [
          _buildBackgroundImage(),
          _buildForegroundImage(screenWidth, screenHeight),
          _buildSkipButton(context),
        ],
      ),
    );
  }

  Widget _buildBackgroundImage() {
    return Positioned.fill(
      child: Image.asset(
        backgroundImage,
        fit: BoxFit.cover, // Ensure background fills the space
      ),
    );
  }

  Widget _buildForegroundImage(double screenWidth, double screenHeight) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: screenWidth * PageViewItemConfig.defaultImageWidthFactor,
          maxHeight: screenHeight * PageViewItemConfig.defaultImageHeightFactor,
        ),
        child: SvgPicture.asset(
          image,
          width: imageWidth ??
              screenWidth * PageViewItemConfig.defaultImageWidthFactor,
          height: imageHeight ??
              screenHeight * PageViewItemConfig.defaultImageHeightFactor,
          fit: BoxFit.contain, // Ensure image fits within constraints
        ),
      ),
    );
  }

  Widget _buildSkipButton(BuildContext context) {
    return Visibility(
      visible: isVisible,
      child: Positioned(
        top: PageViewItemConfig.verticalSpacingSmall,
        right: PageViewItemConfig.skipButtonPadding,
        child: GestureDetector(
          onTap: () {
            Prefs.setBool(kIsOnBoardingViewSeen, true);
            Navigator.of(context).pushReplacementNamed(LoginVeiw.routeName);
          },
          child: const Padding(
            padding: EdgeInsets.all(PageViewItemConfig.skipButtonPadding),
            child: Text(
              'Skip',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSubtitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: PageViewItemConfig.horizontalPadding,
      ),
      child: Text(
        subtitle,
        textAlign: TextAlign.center,
        style: subtitleStyle ??
            const TextStyle(
              color: Color(0xFF4E5456),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
      ),
    );
  }
}
