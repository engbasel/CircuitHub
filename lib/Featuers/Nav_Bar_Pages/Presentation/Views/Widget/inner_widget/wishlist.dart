import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:store/Featuers/Nav_Bar_Pages/Presentation/Views/Widget/inner_widget/wishlist_body.dart';
import 'package:store/Core/Utils/app_name_animated_text.dart';
import 'package:store/Core/Utils/assets.dart';
import 'package:store/Core/Utils/show_dialog.dart';
import 'package:store/Core/Widget/empty_widget.dart';
import 'package:store/providers/wishlist_provider.dart';

class Wishlist extends StatelessWidget {
  const Wishlist({super.key});
  static const routeName = 'wishlist';

  @override
  Widget build(BuildContext context) {
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    Size size = MediaQuery.of(context).size;

    return wishlistProvider.getwishlistItems.isEmpty
        ? EmptyWidget(
            size: size,
            image: Assets.users_imagesBagBagWish,
            title: 'Your wishlist is empty',
            subtitle:
                'Looks like you haven\'t added anything in your wishlist yet.',
            texButoon: 'Shop Now',
          )
        : Scaffold(
            appBar: AppBar(
              title: AppNameAnimatedText(
                text:
                    'Wishlist ( ${wishlistProvider.getwishlistItems.length} )',
                fontSize: 20,
              ),
              leading: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Image.asset(Assets.admin_imagesShoppingCart),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    ShowDialogClass.showDialogClass(
                      context: context,
                      text: 'Remove all items ?',
                      function: () {
                        wishlistProvider.clearWishlistFromFirebase();
                        // wishlistProvider.clearLocalWishlist();
                      },
                    );
                  },
                  icon: const Icon(
                    IconlyLight.delete,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            body: const WishlistBody(),
          );
  }
}
