import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:store/Featuers/authUseingProvider/user_model.dart';

class UserProvider with ChangeNotifier {
  UserModelProvider? userModel;
  UserModelProvider? get getUserModel {
    return userModel;
  }

  Future<void> createUser(String userId, String userName, String userEmail,
      String userStatus, String userImage) async {
    try {
      final userDoc =
          FirebaseFirestore.instance.collection("users").doc(userId);
      await userDoc.set({
        'userId': userId,
        'userName': userName,
        'userEmail': userEmail,
        'userImage': userImage,
        'userStatus': userStatus, // Initial user status
        'userCart': [],
        'userWish': [],
        'createdAt': FieldValue.serverTimestamp(),
      });
    } on FirebaseException catch (error) {
      throw error.message.toString();
    } catch (error) {
      rethrow;
    }
  }

  Future<UserModelProvider?> fetchUserInfo() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    if (user == null) {
      return null;
    }
    var uid = user.uid;
    try {
      final userDoc =
          await FirebaseFirestore.instance.collection("users").doc(uid).get();
      final userDocDict = userDoc.data();
      userModel = UserModelProvider.fromMap(userDocDict!);
      return userModel;
    } on FirebaseException catch (error) {
      throw error.message.toString();
    } catch (error) {
      rethrow;
    }
  }
}
