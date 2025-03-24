import 'package:flutter/material.dart';
import 'package:store/Core/Utils/app_name_animated_text.dart';

import 'package:store/Core/Utils/assets.dart';
import 'package:store/Featuers/Nav_Bar_Pages/Presentation/Views/Widget/home/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.pushNamed(context, 'ChatBotViewBody');
      //   },
      //   backgroundColor: Colors.blue,
      //   child: const Icon(Icons.shopping_cart),
      // ),
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
      body: const HomeViewBody(),
    );
  }
}
