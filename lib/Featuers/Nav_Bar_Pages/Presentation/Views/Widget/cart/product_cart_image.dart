import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/Featuers/Nav_Bar_Pages/Models/cart_model.dart';
import 'package:store/providers/product_provider.dart';

class ProductCartImage extends StatelessWidget {
  const ProductCartImage({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    final cartModelProvider = Provider.of<CartModel>(context);
    final productProvider = Provider.of<ProductProvider>(context);

    final getCurrProduct =
        productProvider.findByProdId(cartModelProvider.productId);
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: FancyShimmerImage(
        height: size.height * 0.2,
        width: size.height * 0.2,
        imageUrl: getCurrProduct!.productImage,
        errorWidget:
            Image.network('https://via.placeholder.com/150?text=No+Image'),
      ),
    );
  }
}
