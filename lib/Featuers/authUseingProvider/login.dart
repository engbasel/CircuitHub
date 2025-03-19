import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:store/Core/Helper_Functions/failuer_top_snak_bar.dart';
import 'package:store/Core/Helper_Functions/scccess_top_snak_bar.dart';
import 'package:store/Core/Utils/app_name_animated_text.dart';
import 'package:store/Core/Utils/app_styles.dart';
import 'package:store/Core/Utils/assets.dart';
import 'package:store/Core/Utils/loading_manager.dart';
import 'package:store/Core/Widget/custom_botton.dart';
import 'package:store/Core/Widget/custom_text_field.dart';
import 'package:store/Core/Widget/nav_bar.dart';
import 'package:store/Core/errors/exceptions.dart';
import 'package:store/Featuers/authUseingProvider/dont_have_an_account_widget.dart';
import 'package:store/Featuers/authUseingProvider/forgot_password_view.dart';

import 'package:store/Featuers/authUseingProvider/google_btn.dart';
import 'package:store/Featuers/authUseingProvider/or_divider.dart';
import 'package:store/Featuers/authUseingProvider/password_field.dart';
import 'package:store/Featuers/authUseingProvider/social_login_button.dart';
import 'package:store/constans.dart';

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

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    // Focus Nodes
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  // Sign in with Email and Password
  Future<User?> loginFct(
      {required String email, required String password}) async {
    setState(() {
      isLoading = true;
    });

    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (!mounted) return credential.user;

      succesTopSnackBar(
        context,
        'Login Successful',
      );

      Navigator.pushReplacementNamed(context, NavBar.routeName);

      return credential.user;
    } on FirebaseAuthException catch (e) {
      log('FirebaseAuthException in _loginFct: ${e.code}');

      String errorMessage = '';

      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'No user found for this email.';
          break;
        case 'wrong-password':
          errorMessage = 'Incorrect password. Please try again.';
          break;
        case 'network-request-failed':
          errorMessage = 'Please check your internet connection.';
          break;
        default:
          errorMessage = 'An error occurred. Please try again later.';
      }

      // Show top snackbar with error message
      failuerTopSnackBar(context, errorMessage);

      throw CustomExceptions(message: errorMessage);
    } catch (e) {
      log('Exception in _loginFct: ${e.toString()}');

      // If the error is unrelated to FirebaseAuth, like network issues, show a generic error message
      failuerTopSnackBar(
          context, 'An unexpected error occurred. Please try again later.');

      throw CustomExceptions(
          message: 'An unexpected error occurred. Please try again later.');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
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
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Welcome back",
                      style: AppStyles.styleSemiBold24,
                    ),
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Let's get you logged in so you can start exploring",
                      style: AppStyles.styleMedium14,
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
                          onFieldSubmitted: (value) async {
                            await loginFct(
                              email: _emailController.text,
                              password: _passwordController.text,
                            );
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
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        CustomBotton(
                          onPressed: () async {
                            await loginFct(
                              email: _emailController.text,
                              password: _passwordController.text,
                            );
                          },
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
                            Navigator.pushNamed(context, NavBar.routeName);
                          },
                          image: Assets.users_imagesGuest,
                          tital: 'Sign in as Guest',
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
