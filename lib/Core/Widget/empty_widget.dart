import 'package:flutter/material.dart';
import 'package:store/Core/Utils/app_styles.dart';
import 'package:store/Core/Widget/custom_botton.dart';
import 'package:store/constans.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    super.key,
    required this.size,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.texButoon,
  });

  final Size size;
  final String image, title, subtitle, texButoon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kHorizintalPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image,
              height: size.height * 0.3,
              width: double.infinity,
            ),
            const SizedBox(height: 20),
            Text(
              'Woops!!',
              style: AppStyles.styleBold30.copyWith(
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 20),
            Text(title, style: AppStyles.styleMedium20),
            const SizedBox(height: 20),
            Text(
              subtitle,
              style: AppStyles.styleRegular16,
            ),
            const SizedBox(height: 80),
            CustomBotton(
              width: size.width * 0.5,
              onPressed: () {},
              text: texButoon,
            )
          ],
        ),
      ),
    );
  }
}
