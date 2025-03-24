// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:store/Core/Helper_Functions/scccess_top_snak_bar.dart';
import 'package:store/Core/Utils/assets.dart';
import 'package:store/Core/Utils/loading_manager.dart';
import 'package:store/Core/Utils/my_app_method.dart';

import 'dart:developer';

import 'package:store/Featuers/authUseingProvider/social_login_button.dart';
import 'package:store/custom_bottom_nav_bar.dart';

class GoogleButton extends StatefulWidget {
  const GoogleButton({super.key});

  @override
  State<GoogleButton> createState() => _GoogleButtonState();
}

class _GoogleButtonState extends State<GoogleButton> {
  bool isLoading = false;

  Future<User?> signInWithGoogle(BuildContext context) async {
    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut(); // Allow user to choose an account

    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    if (googleUser == null) {
      setState(() {
        isLoading = false;
      });
      return null; // User canceled the login
    }

    try {
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final User? user =
          (await FirebaseAuth.instance.signInWithCredential(credential)).user;

      if (user != null) {
        // Ensure that the widget is still mounted before UI updates
        if (!mounted) return null;

        // Check if it's a new user and store their information in Firestore
        if ((await FirebaseAuth.instance
                // ignore: deprecated_member_use
                .fetchSignInMethodsForEmail(user.email!))
            .isEmpty) {
          await FirebaseFirestore.instance
              .collection("users")
              .doc(user.uid)
              .set({
            'userId': user.uid,
            'userName': user.displayName,
            'userImage': user.photoURL,
            'userEmail': user.email,
            'createdAt': Timestamp.now(),
            'userWish': [],
            'userCart': [],
          });
        }

        // Navigate to the main screen after login
        if (!mounted) return null;

        Navigator.pushReplacementNamed(context, CustomBottomNavBar.routeName);
        succesTopSnackBar(
          context,
          'Wellcome ${user.displayName}',
        );
      }

      return user;
    } on FirebaseAuthException catch (e) {
      log('FirebaseAuthException in signInWithGoogle: ${e.toString()}');
      setState(() {
        isLoading = false;
      });

      if (e.code == 'account-exists-with-different-credential') {
        await MyAppMethods.showErrorORWarningDialog(
          context: context,
          subtitle: 'An account already exists with a different credential.',
          fct: () {},
        );
      } else {
        await MyAppMethods.showErrorORWarningDialog(
          context: context,
          subtitle: 'An error occurred during Google Sign-In: ${e.message}',
          fct: () {},
        );
      }
      rethrow;
    } catch (e) {
      log('Exception in signInWithGoogle: ${e.toString()}');
      setState(() {
        isLoading = false;
      });

      await MyAppMethods.showErrorORWarningDialog(
        context: context,
        subtitle:
            'An error occurred during Google Sign-In. Please try again later.',
        fct: () {},
      );
      rethrow;
    } finally {
      setState(() {
        isLoading =
            false; // Stop the loading indicator once the process is done
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoadingManager(
      isLoading: isLoading,
      child: SocialLoginButton(
          image: Assets.users_imagesGoogle,
          tital: 'Sign in with Google',
          onPressed: () {
            signInWithGoogle(context);
            setState(() {
              isLoading = true;
            });
          }),
    );
  }
}
