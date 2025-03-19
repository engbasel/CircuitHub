import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:store/Core/Utils/app_styles.dart';

class AppNameAnimatedText extends StatelessWidget {
  const AppNameAnimatedText({
    super.key,
    this.fontSize = 15,
    required this.text,
  });
  final double fontSize;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.purple,
      highlightColor: Colors.red,
      period: const Duration(seconds: 10),
      child: Text(
        text,
        style: AppStyles.styleBold24.copyWith(fontSize: fontSize),
      ),
    );
  }
}
