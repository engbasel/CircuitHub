import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:store/Core/Utils/app_name_animated_text.dart';
import 'package:store/Core/Utils/custom_progrss_hud.dart';
import 'package:store/Core/Utils/show_dialog.dart';
import 'package:store/Core/Widget/custom_botton.dart';
import 'package:store/Core/Widget/custom_text_field.dart';
import 'package:store/Featuers/authUseingProvider/user_model.dart'; // Use UserModelProvider

class EditUserInfoView extends StatefulWidget {
  final String uid;
  final UserModelProvider userModelProvider; // Replaced with UserModelProvider
  final VoidCallback onUserInfoUpdated;

  const EditUserInfoView({
    super.key,
    required this.uid,
    required this.userModelProvider,
    required this.onUserInfoUpdated,
  });

  @override
  EditUserInfoViewState createState() => EditUserInfoViewState();
}

class EditUserInfoViewState extends State<EditUserInfoView> {
  late TextEditingController nameController;

  XFile? profileImage;
  String? profilePicUrl;
  bool isLoading = false;

  final String defaultProfileImage =
      'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png';

  @override
  void initState() {
    super.initState();
    nameController =
        TextEditingController(text: widget.userModelProvider.userName);
    // Assuming `userModelProvider` has a `bio` or similar field; update this if necessary

    profilePicUrl = widget.userModelProvider.userImage;
  }

  @override
  void dispose() {
    nameController.dispose();

    super.dispose();
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();

    await ShowDialogClass.userImagePickerDialog(
      context: context,
      cameraFCT: () {
        picker.pickImage(source: ImageSource.camera).then((value) {
          setState(() {
            profileImage = value;
          });
        });
      },
      galleryFCT: () {
        picker.pickImage(source: ImageSource.gallery).then((value) {
          setState(() {
            profileImage = value;
          });
        });
      },
      // removeFCT: () {
      //   setState(() {
      //     profileImage = null;
      //     profilePicUrl = null;
      //   });
      //   succesTopSnackBar(context, 'Profile image removed successfully');
      // },
    );
  }

  Future<String?> _uploadImageToFirebase(String filePath) async {
    try {
      final storageRef = FirebaseStorage.instance.ref();
      final file = File(filePath);
      final fileName = file.uri.pathSegments.last;
      final imageRef = storageRef.child("profile_pics/$fileName");
      final uploadTask = imageRef.putFile(file);
      final snapshot = await uploadTask.whenComplete(() => null);
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      debugPrint("Error uploading image: $e");
      return null;
    }
  }

  Future<void> _deleteImageFromFirebase(String imageUrl) async {
    try {
      final ref = FirebaseStorage.instance.refFromURL(imageUrl);
      await ref.delete();
      debugPrint("Image deleted successfully from Firebase Storage");
    } catch (e) {
      debugPrint("Error deleting image: $e");
    }
  }

  Future<void> _updateUserInfo() async {
    setState(() {
      isLoading = true;
    });

    try {
      if (profileImage != null) {
        profilePicUrl = await _uploadImageToFirebase(profileImage!.path);
      }

      if (profileImage == null &&
          profilePicUrl == null &&
          widget.userModelProvider.userImage.isNotEmpty) {
        await _deleteImageFromFirebase(widget.userModelProvider.userImage);
      }

      final updatedUserInfo = {
        'userName': nameController.text,
        // Assuming the bio field should be saved in Firestore

        'userImage': profilePicUrl,
      };

      await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .update(updatedUserInfo);

      widget.onUserInfoUpdated();

      if (mounted) {
        Navigator.of(context).pop();
      }
    } catch (e) {
      debugPrint("Error updating user info: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppNameAnimatedText(
          text: 'Edit Profile',
          fontSize: 20,
        ),
      ),
      body: CustomProgrssHud(
        isLoading: isLoading,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 24),
                GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 70,
                    backgroundImage: profileImage != null
                        ? FileImage(File(profileImage!.path))
                        : (profilePicUrl != null && profilePicUrl!.isNotEmpty)
                            ? NetworkImage(profilePicUrl!)
                            : NetworkImage(defaultProfileImage),
                  ),
                ),
                const SizedBox(height: 24),
                CustomTextFormField(
                  hintText: 'Name',
                  controller: nameController,
                  prefixIcon: const Icon(Icons.person, color: Colors.grey),
                  textInputType: TextInputType.name,
                ),
                const SizedBox(height: 24),
                CustomBotton(
                  text: 'Update',
                  onPressed: _updateUserInfo,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
