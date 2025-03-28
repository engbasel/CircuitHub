import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:store/Core/Helper_Functions/failuer_top_snak_bar.dart';
import 'package:store/Core/Helper_Functions/scccess_top_snak_bar.dart';
import 'package:store/Core/Widget/custom_bottom_nav_bar.dart';
import 'package:store/Core/errors/exceptions.dart';
import 'package:store/Featuers/authUseingProvider/BlockedScreen.dart';

class LoginHandler {
  Future<User?> loginFct({
    required String email,
    required String password,
    required BuildContext context,
    required VoidCallback setLoading,
  }) async {
    setLoading(); // Set loading state

    try {
      // Sign in with Firebase Authentication
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;
      if (user == null) throw FirebaseAuthException(code: 'user-not-found');

      // Fetch user data from Firestore
      final userDoc = await FirebaseFirestore.instance
          .collection('users') // Ensure this is the correct collection name
          .doc(user.uid)
          .get();

      if (!userDoc.exists) {
        throw FirebaseAuthException(code: 'user-not-found');
      }

      final userData = userDoc.data();
      final String userStatus = userData?['userStatus'] ?? '';

      if (!context.mounted) return user;

      if (userStatus == 'USERALLOWED') {
        succesTopSnackBar(context, 'Login Successful');
        Navigator.pushReplacementNamed(context, CustomBottomNavBar.routeName);
      } else if (userStatus == 'USERBLOCKED') {
        failuerTopSnackBar(context, 'Your account is blocked.');
        Navigator.pushReplacementNamed(context, BlockedScreen.routeName);
      } else {
        failuerTopSnackBar(context, 'Unknown status. Please contact support.');
      }

      return user;
    } on FirebaseAuthException catch (e) {
      log('FirebaseAuthException in loginFct: ${e.code}');
      String errorMessage;

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

      if (context.mounted) {
        failuerTopSnackBar(context, errorMessage);
      }
      throw CustomExceptions(message: errorMessage);
    } catch (e) {
      log('Exception in loginFct: ${e.toString()}');

      if (context.mounted) {
        failuerTopSnackBar(
            context, 'An unexpected error occurred. Please try again later.');
      }
      throw CustomExceptions(
          message: 'An unexpected error occurred. Please try again later.');
    } finally {
      setLoading(); // Reset loading state
    }
  }
}
