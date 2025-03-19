import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:store/Core/Utils/app_styles.dart';

class GeneralCustomListTile extends StatelessWidget {
  const GeneralCustomListTile({
    super.key,
    required this.image,
    required this.title,
    required this.onTap,
  });
  final void Function() onTap;
  final String image, title;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Image.asset(
        image,
        height: 30,
      ),
      title: Text(
        title,
        style: AppStyles.styleMedium16,
      ),
      trailing: const Icon(IconlyLight.arrowRight2),
    );
  }
}
