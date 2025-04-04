// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:store/Core/Utils/app_name_animated_text.dart';
import 'package:store/Core/Utils/app_styles.dart';
import 'package:store/Core/Utils/assets.dart';
import 'package:store/Featuers/Nav_Bar_Pages/Presentation/Views/Widget/inner_widget/product_details.dart';
import 'package:store/providers/cart_provider.dart';

import 'package:store/providers/wishlist_provider.dart';
import 'package:store/Core/Utils/app_colors.dart';

class CategoryDetailsView extends StatelessWidget {
  final String categoryName;

  const CategoryDetailsView({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double horizontalPadding = size.width * 0.04;
    double verticalPadding = size.height * 0.01;
    double crossAxisSpacing = size.width * 0.04;
    double mainAxisSpacing = size.height * 0.02;
    int crossAxisCount = size.width > 600 ? 3 : 2;
    double childAspectRatio = size.width > 600 ? 0.75 : 0.85;

    final cartProvider = Provider.of<CartProvider>(context);
    final wishlistProvider = Provider.of<WishlistProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: AppNameAnimatedText(
          text: categoryName,
          fontSize: 20,
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Image.asset(Assets.admin_imagesShoppingCart),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding, vertical: verticalPadding),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('electrionuics_product')
              .where('productCategory', isEqualTo: categoryName)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(
                child: Text(
                  'No products found',
                  style: TextStyle(
                      fontSize: size.width * 0.045,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
              );
            }

            var products = snapshot.data!.docs;

            return GridView.builder(
              padding: EdgeInsets.only(top: verticalPadding),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: crossAxisSpacing,
                mainAxisSpacing: mainAxisSpacing,
                childAspectRatio: childAspectRatio,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                var product = products[index].data() as Map<String, dynamic>;
                String productId = products[index].id;

                return CatigoryWidgetCardDeaitels(
                    product: product,
                    wishlistProvider: wishlistProvider,
                    productId: productId,
                    cartProvider: cartProvider);
              },
            );
          },
        ),
      ),
    );
  }
}

class CatigoryWidgetCardDeaitels extends StatefulWidget {
  const CatigoryWidgetCardDeaitels({
    super.key,
    required this.product,
    required this.wishlistProvider,
    required this.productId,
    required this.cartProvider,
  });

  final Map<String, dynamic> product;
  final WishlistProvider wishlistProvider;
  final String productId;
  final CartProvider cartProvider;

  @override
  State<CatigoryWidgetCardDeaitels> createState() =>
      _CatigoryWidgetCardDeaitelsState();
}

class _CatigoryWidgetCardDeaitelsState
    extends State<CatigoryWidgetCardDeaitels> {
  @override
  Widget build(BuildContext context) {
    bool isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () {
        if (widget.productId.isNotEmpty) {
          Navigator.pushNamed(
            context,
            ProductDetails.routeName,
            arguments: widget.productId,
          );
        } else {
          debugPrint("Error: productId is null or empty!");
        }
      },
      child: Card(
        shadowColor: isDarkTheme ? Colors.black54 : Colors.white,
        color: isDarkTheme
            ? AppColors.darkScaffoldColor
            : AppColors.lightScaffoldColor,
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 3, // زيادة حجم الصورة داخل البطاقة
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.network(
                  widget.product['productImage'],
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product['productTitle'],
                    style: AppStyles.styleMedium16.copyWith(
                      color: isDarkTheme ? Colors.white : Colors.black,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "\$${widget.product['productPrice']}",
                    style: AppStyles.styleBold16.copyWith(
                      color: Colors.redAccent,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Quantity: ${widget.product['productQuantity']}",
                    style: AppStyles.styleMedium14.copyWith(
                      color: isDarkTheme ? Colors.grey[300] : Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          widget.wishlistProvider.addOrRemoveFromWishlist(
                              productId: widget.productId);
                        },
                        icon: Icon(
                          widget.wishlistProvider.isProductInWishlist(
                                  productId: widget.productId)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          size: 24,
                          color: widget.wishlistProvider.isProductInWishlist(
                                  productId: widget.productId)
                              ? Colors.red
                              : (isDarkTheme ? Colors.white : Colors.grey),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          if (!widget.cartProvider
                              .isProductInCart(productId: widget.productId)) {
                            widget.cartProvider.addToCartFirebase(
                              productId: widget.productId,
                              qty: 1,
                              context: context,
                            );
                          }
                        },
                        icon: Icon(
                          widget.cartProvider
                                  .isProductInCart(productId: widget.productId)
                              ? Icons.check
                              : Icons.add_shopping_cart_outlined,
                          size: 24,
                          color: widget.cartProvider
                                  .isProductInCart(productId: widget.productId)
                              ? Colors.green
                              : (isDarkTheme
                                  ? AppColors.darkPrimary
                                  : AppColors.lightPrimary),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
