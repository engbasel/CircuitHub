import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:store/Core/Utils/app_name_animated_text.dart';
import 'package:store/Core/Utils/app_styles.dart';
import 'package:store/Core/Utils/loading_manager.dart';
import 'package:store/Core/Utils/my_app_method.dart';
import 'package:store/Core/Widget/custom_botton.dart';
import 'package:store/Core/Widget/custom_text_field.dart';

import 'package:store/Featuers/authUseingProvider/have_an_account_widget.dart';
import 'package:store/Featuers/authUseingProvider/password_field.dart';
import 'package:store/Featuers/authUseingProvider/pick_image_widget.dart';
import 'package:store/constans.dart';
import 'package:store/Core/Widget/custom_bottom_nav_bar.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = 'RegisterScreen';
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late final TextEditingController _nameController,
      _emailController,
      _passwordController,
      _confirmPasswordController;

  late final FocusNode _nameFocusNode,
      _emailFocusNode,
      _passwordFocusNode,
      _confirmPasswordFocusNode;
  late final _formKey = GlobalKey<FormState>();
  bool obscureText = true;
  bool _isLoading = false;
  XFile? _pickedImage;
  final auth = FirebaseAuth.instance;
  String? userImageUrl;
  @override
  void initState() {
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    // Focus Nodes
    _nameFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _confirmPasswordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    // Focus Nodes
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  Future<void> _registerFct() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (_pickedImage == null) {
      MyAppMethods.showErrorORWarningDialog(
        context: context,
        subtitle: "Make sure to pick up an image",
        fct: () {},
      );
      return;
    }
    if (isValid) {
      _formKey.currentState!.save();
      try {
        setState(() {
          _isLoading = true;
        });
        final ref = FirebaseStorage.instance
            .ref()
            .child("usersImages")
            .child('${_emailController.text.trim()}.jpg');
        await ref.putFile(File(_pickedImage!.path));
        userImageUrl = await ref.getDownloadURL();

        await auth.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        User? user = auth.currentUser;
        final uid = user!.uid;
        await FirebaseFirestore.instance.collection("users").doc(uid).set({
          'userId': uid,
          'userName': _nameController.text,
          'userImage': userImageUrl,
          'userEmail': _emailController.text.toLowerCase(),
          'createdAt': Timestamp.now(),
          'userWish': [],
          'userStatus': 'USERALLOWED',
          'userCart': [],
        });
        Fluttertoast.showToast(
          msg: "An account has been created",
          toastLength: Toast.LENGTH_SHORT,
          textColor: Colors.white,
        );
        if (!mounted) return;
        Navigator.pushReplacementNamed(context, CustomBottomNavBar.routeName);
      } on FirebaseAuthException catch (error) {
        await MyAppMethods.showErrorORWarningDialog(
          context: context,
          subtitle: "An error has been occured ${error.message}",
          fct: () {},
        );
      } catch (error) {
        await MyAppMethods.showErrorORWarningDialog(
          context: context,
          subtitle: "An error has been occured $error",
          fct: () {},
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> localImagePicker() async {
    final ImagePicker picker = ImagePicker();
    await MyAppMethods.imagePickerDialog(
      context: context,
      cameraFCT: () async {
        _pickedImage = await picker.pickImage(source: ImageSource.camera);
        setState(() {});
      },
      galleryFCT: () async {
        _pickedImage = await picker.pickImage(source: ImageSource.gallery);
        setState(() {});
      },
      removeFCT: () {
        setState(() {
          _pickedImage = null;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: LoadingManager(
          isLoading: _isLoading,
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Wellcome',
                          style: AppStyles.styleSemiBold24,
                        ),
                        Text(
                          "Sign up now to receive special offers and updates from our app",
                          style: AppStyles.styleMedium14,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  SizedBox(
                    height: size.width * 0.45,
                    width: size.width * 0.45,
                    child: PickImageWidget(
                      pickedImage: _pickedImage,
                      function: () async {
                        await localImagePicker();
                      },
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
                          onSaved: (value) {
                            _nameController.text = value!;
                          },
                          hintText: 'Full Name',
                          textInputType: TextInputType.name,
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).requestFocus(
                              _emailFocusNode,
                            );
                          },
                          validator: (value) {
                            return MyValidators.displayNamevalidator(
                              value,
                            );
                          },
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        CustomTextFormField(
                          onSaved: (value) {
                            _emailController.text = value!;
                          },
                          hintText: 'Email',
                          textInputType: TextInputType.emailAddress,
                          focusNode: _emailFocusNode,
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).requestFocus(
                              _passwordFocusNode,
                            );
                          },
                          validator: (value) {
                            return MyValidators.emailValidator(
                              value,
                            );
                          },
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        PasswordField(
                          hintText: 'Password',
                          controller: _passwordController,
                          onSaved: (value) {
                            _passwordController.text = value!;
                          },
                          focusNode: _passwordFocusNode,
                          validator: (value) {
                            return MyValidators.passwordValidator(
                              value,
                            );
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        PasswordField(
                          controller: _confirmPasswordController,
                          hintText: 'Confirm Password',
                          onSaved: (value) {
                            _confirmPasswordController.text = value!;
                          },
                          focusNode: _confirmPasswordFocusNode,
                          validator: (value) {
                            return MyValidators.repeatPasswordValidator(
                              value: value,
                              password: _passwordController.text,
                            );
                          },
                        ),
                        const SizedBox(
                          height: 25.0,
                        ),
                        CustomBotton(
                          onPressed: () async {
                            await _registerFct();
                          },
                          text: 'Sign Up',
                        ),
                        const SizedBox(
                          height: 25.0,
                        ),
                        const HaveAnAccountWidget(),
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
