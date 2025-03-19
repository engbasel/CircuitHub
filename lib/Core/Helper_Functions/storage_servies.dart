import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<String> uploadProfileImage(String filePath, String userId) async {
    File file = File(filePath);
    try {
      // Upload file to Firebase Storage with a reference to the user's folder
      TaskSnapshot snapshot =
          await _firebaseStorage.ref('profile_images/$userId').putFile(file);

      // Get the URL of the uploaded image
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      throw Exception("Image upload failed: $e");
    }
  }
}
