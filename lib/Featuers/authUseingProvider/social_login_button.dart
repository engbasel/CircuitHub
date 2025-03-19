import 'package:flutter/material.dart';
import 'package:store/Core/Utils/app_styles.dart';

class SocialLoginButton extends StatelessWidget {
  const SocialLoginButton(
      {super.key,
      required this.image,
      required this.tital,
      required this.onPressed});
  final String image;
  final String tital;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Color(0xffdcdede), width: 1),
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        onPressed: onPressed,
        child: ListTile(
          visualDensity: const VisualDensity(
            vertical: VisualDensity.minimumDensity,
          ),
          leading: Image.asset(image),
          title: Text(
            tital,
            textAlign: TextAlign.center,
            style: AppStyles.styleMedium16,
          ),
        ),
      ),
    );
  }
}
