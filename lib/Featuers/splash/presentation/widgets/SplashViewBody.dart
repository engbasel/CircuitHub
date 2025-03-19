import 'package:flutter/material.dart';
import 'package:store/Core/Utils/app_colors.dart';
import 'package:store/Core/Utils/assets.dart';
import 'package:store/Featuers/splash/presentation/AnimationConfig.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  _SplashViewBodyState createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimation();
  }

  void _setupAnimation() {
    _controller = AnimationController(
      vsync: this,
      duration: AnimationConfig.scaleDuration,
    );

    // Fade animation
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: AnimationConfig.fadeCurve),
      ),
    );

    // Scale animation with subtle zoom in-out
    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.8, end: AnimationConfig.maxScale),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: AnimationConfig.maxScale,
          end: AnimationConfig.minScale,
        ),
        weight: 25,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: AnimationConfig.minScale, end: 1.0),
        weight: 25,
      ),
    ]).animate(
      CurvedAnimation(parent: _controller, curve: AnimationConfig.scaleCurve),
    );

    _controller
      ..forward()
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.repeat(reverse: true);
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: _buildSplashContent(context)));
  }

  Widget _buildSplashContent(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildAnimatedLogo(screenWidth, screenHeight),
        const SizedBox(height: 24),
        _buildWelcomeText(screenWidth),
        const SizedBox(height: 12),
        _buildMotivationalText(screenWidth),
      ],
    );
  }

  Widget _buildAnimatedLogo(double screenWidth, double screenHeight) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Image.asset(
          Assets.logo,
          width: screenWidth * 0.45,
          height: screenHeight * 0.25,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _buildWelcomeText(double screenWidth) {
    return Text(
      "Welcome to Our Store!",
      style: TextStyle(
        fontSize: screenWidth * 0.07,
        fontWeight: FontWeight.bold,
        // color: AppColors.primaryText,
        shadows: const [
          Shadow(
            // color: AppColors.accent.withOpacity(0.2),
            offset: Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildMotivationalText(double screenWidth) {
    return Text(
      "Shop now & get the best deals!\nEverything you need in one place 🛍️",
      style: TextStyle(
        fontSize: screenWidth * 0.045,
        fontWeight: FontWeight.w500,
        // color: AppColors.secondaryText,
      ),
      textAlign: TextAlign.center,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
