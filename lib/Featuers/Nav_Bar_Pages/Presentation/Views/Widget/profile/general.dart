import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:store/Featuers/Nav_Bar_Pages/Presentation/Views/Widget/inner_widget/orders.dart';
import 'package:store/Featuers/Nav_Bar_Pages/Presentation/Views/Widget/inner_widget/viewed_recently.dart';
import 'package:store/Featuers/Nav_Bar_Pages/Presentation/Views/Widget/inner_widget/wishlist.dart';
import 'package:store/Featuers/Nav_Bar_Pages/Presentation/Views/Widget/profile/general_custom_list_tile.dart';
import 'package:store/Core/Utils/app_styles.dart';
import 'package:store/Core/Utils/assets.dart';

class General extends StatelessWidget {
  const General({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'General',
          style: AppStyles.styleSemiBold18,
        ),
        const SizedBox(
          height: 16,
        ),
        user == null
            ? const SizedBox()
            : GeneralCustomListTile(
                onTap: () async {
                  await Navigator.pushNamed(context, Orders.routeName);
                },
                image: Assets.users_imagesBagOrderSvg,
                title: "All Orders"),
        GeneralCustomListTile(
            onTap: () async {
              await Navigator.pushNamed(context, Wishlist.routeName);
            },
            image: Assets.users_imagesBagWishlistSvg,
            title: "Wishlist"),
        GeneralCustomListTile(
            onTap: () async {
              await Navigator.pushNamed(context, ViewedRecently.routeName);
            },
            image: Assets.users_imagesProfileRecent,
            title: "Viewed recently"),
        user == null
            ? const SizedBox()
            : GeneralCustomListTile(
                onTap: () {},
                image: Assets.users_imagesProfileAddress,
                title: "Address"),
      ],
    );
  }
}
