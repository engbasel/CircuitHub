import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/Core/Widget/product_widget.dart';
import 'package:store/constans.dart';
import 'package:store/providers/wishlist_provider.dart';

class WishlistBody extends StatelessWidget {
  const WishlistBody({super.key});
  @override
  Widget build(BuildContext context) {
    final wishlistProvider = Provider.of<WishlistProvider>(context);

    return DynamicHeightGridView(
      crossAxisCount: 2,
      builder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: kHorizintalPadding),
          child: ProductWidget(
              productId: wishlistProvider.getwishlistItems.values
                  .toList()[index]
                  .productId),
        );
      },
      itemCount: wishlistProvider.getwishlistItems.length,
    );
  }
}
