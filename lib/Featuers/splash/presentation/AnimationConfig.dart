import 'package:flutter/material.dart';

class AnimationConfig {
  static const Duration fadeDuration = Duration(milliseconds: 1500);
  static const Duration scaleDuration = Duration(milliseconds: 800);
  static const Curve fadeCurve = Curves.easeIn;
  static const Curve scaleCurve = Curves.easeInOut;
  static const double minScale = 0.95;
  static const double maxScale = 1.05;
}
