// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:store/Core/Utils/my_app_method.dart';
import 'package:store/providers/wishlist_provider.dart';

class HeartBottom extends StatefulWidget {
  const HeartBottom(
      {super.key,
      this.size = 22,
      this.color = Colors.transparent,
      required this.productId});
  final double size;
  final Color? color;
  final String productId;
  @override
  State<HeartBottom> createState() => _HeartBottomState();
}

class _HeartBottomState extends State<HeartBottom> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final wishlistProvider = Provider.of<WishlistProvider>(context);

    return Material(
      color: widget.color,
      shape: const CircleBorder(),
      child: IconButton(
        onPressed: () async {
          // wishlistProvider.addOrRemoveFromWishlist(
          //   productId: widget.productId,
          // );
          setState(() {
            isLoading = true;
          });
          try {
            if (wishlistProvider.getwishlistItems
                .containsKey(widget.productId)) {
              wishlistProvider.removeWishlistItemFromFirebase(
                  productId: widget.productId,
                  wishlistId:
                      wishlistProvider.getwishlistItems[widget.productId]!.id);
            } else {
              wishlistProvider.addToWishlistFirebase(
                productId: widget.productId,
                context: context,
              );
            }
            await wishlistProvider.fetchWishlist();
          } catch (error) {
            MyAppMethods.showErrorORWarningDialog(
              context: context,
              subtitle: error.toString(),
              fct: () {},
            );
          } finally {
            setState(() {
              isLoading = false;
            });
          }
        },
        icon: isLoading
            ? const CircularProgressIndicator()
            : Icon(
                wishlistProvider.isProductInWishlist(
                        productId: widget.productId)
                    ? IconlyBold.heart
                    : IconlyLight.heart,
                size: widget.size,
                color: wishlistProvider.isProductInWishlist(
                        productId: widget.productId)
                    ? Colors.red
                    : Colors.grey,
              ),
      ),
    );
  }
}
