import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:store/Core/Utils/app_styles.dart';
import 'package:store/Core/Utils/assets.dart';
import 'package:store/Core/Widget/custom_botton.dart';
import 'package:store/Core/Widget/custom_text_field.dart';
import 'package:store/constans.dart';

class ForgotPasswordViewBody extends StatefulWidget {
  const ForgotPasswordViewBody({super.key});
  static const routeName = 'ForgotPasswordViewBody';

  @override
  State<ForgotPasswordViewBody> createState() => _ForgotPasswordViewBodyState();
}

class _ForgotPasswordViewBodyState extends State<ForgotPasswordViewBody> {
  final emailController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kHorizintalPadding),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 15),
              Image.asset(
                Assets.users_imagesForgotPassword2,
              ),
              const SizedBox(height: 24),
              const Text(
                'Enter your email address and we will send you a link to reset your password.',
                style: AppStyles.styleMedium16,
              ),
              const SizedBox(height: 24),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    CustomTextFormField(
                      controller: emailController,
                      hintText: 'Email',
                      prefixIcon: const Icon(IconlyLight.message),
                      textInputType: TextInputType.emailAddress,
                      validator: (value) {
                        return MyValidators.emailValidator(value);
                      },
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              CustomBotton(
                isIconNeeded: true,
                onPressed: () {},
                text: 'Request link',
                icon: IconlyBold.send,
                widthS: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
