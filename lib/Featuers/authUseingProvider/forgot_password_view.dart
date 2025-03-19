import 'package:flutter/material.dart';
import 'package:store/Core/Utils/app_name_animated_text.dart';
import 'package:store/Featuers/authUseingProvider/forgot_password_view_body.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});
  static const routeName = 'ForgotPasswordView';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppNameAnimatedText(
          text: 'Forget Password',
          fontSize: 20,
        ),
        centerTitle: true,
      ),
      body: const ForgotPasswordViewBody(),
    );
  }
}
