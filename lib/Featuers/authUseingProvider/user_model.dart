import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserModelProvider with ChangeNotifier {
  final String userId, userName, userImage, userEmail;
  final Timestamp createdAt;
  final List userCart, userWish;
  UserModelProvider({
    required this.userId,
    required this.userName,
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
      userEmail: data['userEmail'],
      userCart: data['userCart'] ?? [],
      userWish: data['userWish'] ?? [],
      createdAt: data['createdAt'],
    );
  }
}
