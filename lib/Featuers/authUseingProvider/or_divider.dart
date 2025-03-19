import 'package:flutter/material.dart';
import 'package:store/Core/Utils/app_styles.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: Divider(
            color: Color(0xffdcdede),
          ),
        ),
        SizedBox(
          width: 18,
        ),
        Text(
          'Or',
          style: AppStyles.styleRegular16,
        ),
        SizedBox(
          width: 18,
        ),
        Expanded(
          child: Divider(
            color: Color(0xffdcdede),
          ),
        ),
      ],
    );
  }
}
