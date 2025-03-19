import 'package:flutter/material.dart';
import 'package:store/Core/Utils/assets.dart';
import 'package:store/Featuers/onboarding/presentation/widgets/page_view_item.dart';

class OnBoardingPageview extends StatelessWidget {
  const OnBoardingPageview({super.key, required this.pageController});

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions using MediaQuery
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return PageView(
      controller: pageController,
      children: [
        PageviewItem(
          isVisible: true,
          image: Assets.arduino, // Asset for resistors
          backgroundImage: Assets.background1,
          subtitle:
              'Find the perfect components for your next big idea. Explore detailed specs, vivid images, and reviews to build with confidence and creativity.',
          title: const Text(
            'Discover & Shop',
            textAlign: TextAlign.center,
            // style: TextStyles.bold19(context),
          ),
          imageWidth: screenWidth * 0.6, // 60% of screen width
          imageHeight: screenHeight * 0.3, // 30% of screen height
          backgroundImageWidth: screenWidth, // Full screen width
          backgroundImageHeight: screenHeight * 0.5, // 50% of screen height
          subtitleStyle: Theme.of(context).textTheme.bodyLarge,
          //  TextStyle(
          //   fontSize: screenWidth * 0.04, // Responsive subtitle size
          //   color: Colors.black,
          // ),
        ),
        PageviewItem(
          isVisible: false,
          image: Assets.Curicates, // Asset for resistors
          backgroundImage: Assets.background2, // Asset for ICs
          subtitle:
              'Find the perfect components for your next big idea. Explore detailed specs, vivid images, and reviews to build with confidence and creativity.',
          title: const Text(
            'Discover & Shop',
            textAlign: TextAlign.center,
            // style: TextStyles.bold19(context),
          ),
          imageWidth: screenWidth * 0.6, // 60% of screen width
          imageHeight: screenHeight * 0.3, // 30% of screen height
          backgroundImageWidth: screenWidth, // Full screen width
          backgroundImageHeight: screenHeight * 0.5, // 50% of screen height
          subtitleStyle: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}
