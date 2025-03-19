import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:store/Core/Utils/app_styles.dart';
import 'package:store/Core/Utils/my_app_method.dart';
import 'package:store/Core/Widget/heart_botton.dart';
import 'package:store/Featuers/Nav_Bar_Pages/Models/product_model.dart';
import 'package:store/constans.dart';
import 'package:store/providers/cart_provider.dart';
import 'package:store/providers/product_provider.dart';

class ProductDetailsBody extends StatelessWidget {
  const ProductDetailsBody(
      {super.key,
      required this.productProvider,
      required this.productId,
      required this.getCurrProduct});
  final ProductProvider productProvider;
  final String productId;
  final ProductModel getCurrProduct;

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 16),
          FancyShimmerImage(
            imageUrl: getCurrProduct.productImage,
            width: double.infinity,
            height: size.height * 0.4,
            boxFit: BoxFit.contain,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: kHorizintalPadding, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(
                        getCurrProduct.productTitle,
                        style: AppStyles.styleSemiBold18,
                        overflow: TextOverflow.visible,
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.1,
                    ),
                    Text(
                      '${getCurrProduct.productPrice} \$',
                      style: AppStyles.styleMedium16.copyWith(
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kHorizintalPadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      HeartBottom(
                        productId: productId,
                        color: const Color.fromARGB(255, 210, 231, 244),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: SizedBox(
                          height: kBottomNavigationBarHeight - 10,
                          child: ElevatedButton(
                            onPressed: () {
                              if (cartProvider.isProductInCart(
                                  productId: productId)) {
                                return;
                              }
                              try {
                                cartProvider.addToCartFirebase(
                                  productId: getCurrProduct.productId,
                                  qty: 1,
                                  context: context,
                                );
                              } catch (e) {
                                MyAppMethods.showErrorORWarningDialog(
                                  context: context,
                                  subtitle: e.toString(),
                                  fct: () {},
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            )),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(cartProvider.isProductInCart(
                                        productId: productId)
                                    ? Icons.check
                                    : Icons.add_shopping_cart),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                    cartProvider.isProductInCart(
                                            productId: productId)
                                        ? "In Cart"
                                        : "Add To Cart",
                                    style: AppStyles.styleMedium16),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Description',
                      style: AppStyles.styleSemiBold20,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      getCurrProduct.productCategory,
                      style: AppStyles.styleMedium16,
                      overflow: TextOverflow.visible,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  getCurrProduct.productDescription,
                  style: AppStyles.styleMedium16,
                  overflow: TextOverflow.visible,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
