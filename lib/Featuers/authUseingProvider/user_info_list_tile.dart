import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:store/Featuers/authUseingProvider/edit_profile_body.dart';
import 'package:store/Featuers/authUseingProvider/user_model.dart';

class UserInfoListTile extends StatefulWidget {
  final String uid;

  const UserInfoListTile({super.key, required this.uid});

  @override
  UserInfoListTileState createState() => UserInfoListTileState();
}

class UserInfoListTileState extends State<UserInfoListTile> {
  late Future<UserModelProvider> _userInfoFuture;

  @override
  void initState() {
    super.initState();
    _userInfoFuture = fetchUserInfo();
  }

  Future<UserModelProvider> fetchUserInfo() async {
    final docSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.uid)
        .get();

    if (docSnapshot.exists) {
      return UserModelProvider.fromMap(docSnapshot.data()!);
    } else {
      throw Exception("User data not found");
    }
  }

  void _updateUserInfo() {
    setState(() {
      _userInfoFuture =
          fetchUserInfo(); // Reload user info when data is updated
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModelProvider>(
      future: _userInfoFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const ListTile(
            title: Text("Error loading user data"),
          );
        } else if (!snapshot.hasData) {
          return const ListTile(
            title: Text("User data not found"),
          );
        } else {
          final userModel = snapshot.data!;
          String profilePicUrl = userModel.userImage;

          if (profilePicUrl.isEmpty) {
            profilePicUrl =
                'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png';
          }

          return ListTile(
            leading: CircleAvatar(
              backgroundImage: profilePicUrl.startsWith('/')
                  ? FileImage(File(profilePicUrl))
                  : NetworkImage(profilePicUrl) as ImageProvider,
              radius: 30,
            ),
            title: Text(userModel.userName),
            subtitle: Text(userModel.userEmail),
            onTap: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditUserInfoView(
                    uid: widget.uid,
                    userModelProvider: userModel,
                    onUserInfoUpdated: _updateUserInfo,
                  ),
                ),
              );

              if (result == true) {
                _updateUserInfo();
              }
            },
          );
        }
      },
    );
  }
}
