import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:store/Core/Utils/app_styles.dart';
import 'package:store/Core/Utils/assets.dart';

class ShowDialogClass {
  static Future<dynamic> showDialogClass(
      {required BuildContext context,
      required String text,
      required Function function,
      bool isError = false}) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              Assets.users_imagesWarning,
              height: 50,
              width: 50,
              fit: BoxFit.fill,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              text,
              style: AppStyles.styleMedium14,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Visibility(
                  visible: !isError,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Cancel',
                      style: AppStyles.styleMedium20.copyWith(
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    function();
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Ok',
                    style: AppStyles.styleMedium20.copyWith(
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  static Future<void> imagePickerDialog({
    required BuildContext context,
    required Function cameraFCT,
    required Function galleryFCT,
    required Function removeFCT,
  }) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Center(
            child: Text(
              'Select Image',
              style: AppStyles.styleMedium20,
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                TextButton.icon(
                  onPressed: () {
                    cameraFCT();
                    Navigator.pop(context);
                  },
                  label: const Text('photo'),
                  icon: const Icon(IconlyLight.camera),
                ),
                TextButton.icon(
                  onPressed: () {
                    galleryFCT();
                    Navigator.pop(context);
                  },
                  label: const Text('Gallery'),
                  icon: const Icon(Icons.image),
                ),
                TextButton.icon(
                  onPressed: () {
                    removeFCT();
                    Navigator.pop(context);
                  },
                  label: const Text('Remove'),
                  icon: const Icon(Icons.remove),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static Future<void> userImagePickerDialog({
    required BuildContext context,
    required Function cameraFCT,
    required Function galleryFCT,
  }) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Center(
            child: Text(
              'Select Image',
              style: AppStyles.styleMedium20,
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                TextButton.icon(
                  onPressed: () {
                    cameraFCT();
                    Navigator.pop(context);
                  },
                  label: const Text('photo'),
                  icon: const Icon(IconlyLight.camera),
                ),
                TextButton.icon(
                  onPressed: () {
                    galleryFCT();
                    Navigator.pop(context);
                  },
                  label: const Text('Gallery'),
                  icon: const Icon(Icons.image),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
