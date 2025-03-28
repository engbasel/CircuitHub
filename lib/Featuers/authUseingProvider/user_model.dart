import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserModelProvider with ChangeNotifier {
  final String userId, userName, userImage, userEmail, userStatus;
  final Timestamp createdAt;
  final List userCart, userWish;
  UserModelProvider({
    required this.userId,
    required this.userName,
    required this.userStatus,
    required this.userImage,
    required this.userEmail,
    required this.userCart,
    required this.userWish,
    required this.createdAt,
  });

  // Factory method to create a UserModelProvider from a Firestore map
  factory UserModelProvider.fromMap(Map<String, dynamic> data) {
    return UserModelProvider(
      userId: data['userId'],
      userName: data['userName'],
      userImage: data['userImage'],
      userStatus: data['userStatus'],
      userEmail: data['userEmail'],
      userCart: data['userCart'] ?? [],
      userWish: data['userWish'] ?? [],
      createdAt: data['createdAt'],
    );
  }
}
