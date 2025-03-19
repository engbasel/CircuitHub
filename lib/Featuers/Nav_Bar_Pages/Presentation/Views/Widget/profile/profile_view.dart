import 'package:flutter/material.dart';
import 'package:store/Featuers/Nav_Bar_Pages/Presentation/Views/Widget/profile/profile_view_body.dart';
import 'package:store/Core/Utils/app_name_animated_text.dart';
import 'package:store/Core/Utils/assets.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppNameAnimatedText(
          text: 'CircuitHub',
          fontSize: 24,
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Image.asset(Assets.admin_imagesShoppingCart),
        ),
      ),
      body: const ProfileViewBody(),
    );
  }
}
