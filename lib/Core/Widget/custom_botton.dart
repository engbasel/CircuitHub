import 'package:flutter/material.dart';
import 'package:store/Core/Utils/app_styles.dart';

class CustomBotton extends StatelessWidget {
  const CustomBotton(
      {super.key,
      required this.onPressed,
      required this.text,
      this.width = double.infinity,
      this.icon,
      this.background,
      this.widthS,
      this.isIconNeeded = false});
  final VoidCallback onPressed;
  final String text;
  final double width;
  final double? widthS;
  final IconData? icon;
  final Color? background;
  final bool isIconNeeded;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 54,
      child: TextButton(
        style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            backgroundColor: background),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: isIconNeeded,
              child: Icon(
                icon,
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: widthS,
            ),
            Text(
              style: AppStyles.styleSemiBold18.copyWith(
                color: Colors.white,
              ),
              text,
            ),
          ],
        ),
      ),
    );
  }
}
