import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:store/Core/Utils/app_name_animated_text.dart';
import 'package:store/Core/Utils/app_styles.dart';
import 'package:store/Core/Utils/assets.dart';
import 'package:store/Core/Utils/loading_manager.dart';
import 'package:store/Core/Widget/custom_botton.dart';
import 'package:store/Core/Widget/custom_text_field.dart';

import 'package:store/Featuers/authUseingProvider/dont_have_an_account_widget.dart';
import 'package:store/Featuers/authUseingProvider/forgot_password_view.dart';
import 'package:store/Featuers/authUseingProvider/google_btn.dart';
import 'package:store/Featuers/authUseingProvider/login_handeler.dart';
import 'package:store/Featuers/authUseingProvider/or_divider.dart';
import 'package:store/Featuers/authUseingProvider/password_field.dart';
import 'package:store/Featuers/authUseingProvider/social_login_button.dart';
import 'package:store/constans.dart';
import 'package:store/Core/Widget/custom_bottom_nav_bar.dart';
import 'package:store/services/DioServiceHelper.dart';

class LoginVeiw extends StatefulWidget {
  static const routeName = 'LoginVeiw';
  const LoginVeiw({super.key});

  @override
  State<LoginVeiw> createState() => _LoginVeiwState();
}

class _LoginVeiwState extends State<LoginVeiw> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final FocusNode _emailFocusNode;
  late final FocusNode _passwordFocusNode;
  late final _formKey = GlobalKey<FormState>();
  bool obscureText = true;
  bool isLoading = false;

  final auth = FirebaseAuth.instance;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    // Focus Nodes
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    super.initState();
  }

  void toggleLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  void fetchProjects() async {
    ApiService apiService = ApiService();

    Map<String, dynamic> result = await apiService.searchProject(
      projectDescription: "voice control car",
      // requiredComponents: ["arduino", "relay module", "temperature sensor"],
    );

    print(result); // Print response data
  }

  final LoginHandler loginHandler = LoginHandler(); // Instance of LoginHandler

  void login() async {
    await loginHandler.loginFct(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      context: context,
      setLoading: toggleLoading, // ✅ Pass the function reference correctly
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    // Focus Nodes
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get current theme mode
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // Get theme colors
    final textColor = isDarkMode ? Colors.white : Colors.black;
    final backgroundColor =
        isDarkMode ? Theme.of(context).scaffoldBackgroundColor : Colors.white;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: LoadingManager(
          isLoading: isLoading,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 60.0,
                  ),
                  const AppNameAnimatedText(
                    text: "CircuitHub",
                    fontSize: 30,
                    // color: textColor, // Use theme-appropriate color
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Welcome back",
                      style: AppStyles.styleSemiBold24.copyWith(
                        color: textColor, // Use theme-appropriate color
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Let's get you logged in so you can start exploring",
                      style: AppStyles.styleMedium14.copyWith(
                        color: isDarkMode
                            ? Colors.white70
                            : Colors.black54, // Use theme-appropriate color
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomTextFormField(
                          controller: _emailController,
                          focusNode: _emailFocusNode,
                          textInputAction: TextInputAction.next,
                          textInputType: TextInputType.emailAddress,
                          hintText: 'example123@gmail.com',
                          onSaved: (value) {
                            _emailController.text = value!;
                          },
                          validator: (value) {
                            return MyValidators.emailValidator(value);
                          },
                          onFieldSubmitted: (value) {
                            FocusScope.of(context)
                                .requestFocus(_passwordFocusNode);
                          },
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        PasswordField(
                          hintText: 'password',
                          focusNode: _passwordFocusNode,
                          controller: _passwordController,
                          onSaved: (value) {
                            _passwordController.text = value!;
                          },
                          validator: (value) {
                            return MyValidators.passwordValidator(value);
                          },
                          onFieldSubmitted: (p0) {
                            login();
                          },
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, ForgotPasswordView.routeName);
                            },
                            child: Text(
                              "Forgot password?",
                              style: AppStyles.styleRegular16.copyWith(
                                  decoration: TextDecoration.underline,
                                  color:
                                      isDarkMode ? Colors.white : Colors.black),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        CustomBotton(
                          // Get theme-appropriate background color
                          background: isDarkMode ? Colors.white : Colors.black,
                          // Get theme-appropriate text color
                          TextColor: isDarkMode ? Colors.black : Colors.white,
                          onPressed: login,
                          text: 'Sign In',
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        const DontHaveAnAccountWidget(),
                        const SizedBox(
                          height: 16.0,
                        ),
                        const OrDivider(),
                        const SizedBox(
                          height: 16.0,
                        ),
                        const SizedBox(child: GoogleButton()),
                        const SizedBox(
                          height: 16.0,
                        ),
                        SocialLoginButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, CustomBottomNavBar.routeName);
                          },
                          image: Assets.users_imagesGuest,
                          tital: 'Sign in as Guest',
                        )
                      ],
                    ),
                  ),
                  TextButton(
                      onPressed: fetchProjects, child: const Text('testAi'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
