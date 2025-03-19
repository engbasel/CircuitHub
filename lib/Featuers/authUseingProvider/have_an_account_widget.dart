import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:store/Core/Utils/app_styles.dart';

class HaveAnAccountWidget extends StatelessWidget {
  const HaveAnAccountWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
              text: 'Already have an account? ',
              style: AppStyles.styleRegular16.copyWith(
                color: const Color(0xff949d9e),
              )),
          TextSpan(
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.pop(context);
              },
            text: 'LogIn',
            style: AppStyles.styleSemiBold16.copyWith(
              decoration: TextDecoration.underline,
            ),
          ),
        ],
      ),
    );
  }
}
