import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:store/Core/Utils/app_name_animated_text.dart';
import 'package:store/Core/Utils/app_styles.dart';
import 'package:store/Core/Utils/assets.dart';
import 'package:store/providers/cart_provider.dart';
import 'package:store/providers/wishlist_provider.dart';

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

                return Card(
                  shadowColor: Colors.white,
                  color: Colors.white,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(12)),
                          child: Image.network(
                            product['productImage'],
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
                              product['productTitle'],
                              style: AppStyles.styleMedium16,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "\$${product['productPrice']}",
                              style: AppStyles.styleBold16
                                  .copyWith(color: Colors.redAccent),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Quantity: ${product['productQuantity']}",
                              style: AppStyles.styleMedium14
                                  .copyWith(color: Colors.grey),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                /// **Wishlist Button (حب)**
                                IconButton(
                                  onPressed: () {
                                    wishlistProvider.addOrRemoveFromWishlist(
                                        productId: productId);
                                  },
                                  icon: Icon(
                                    wishlistProvider.isProductInWishlist(
                                            productId: productId)
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    size: 24,
                                    color: wishlistProvider.isProductInWishlist(
                                            productId: productId)
                                        ? Colors.red
                                        : Colors.grey,
                                  ),
                                ),

                                /// **Cart Button (سلة التسوق)**
                                IconButton(
                                  onPressed: () {
                                    if (!cartProvider.isProductInCart(
                                        productId: productId)) {
                                      cartProvider.addToCartFirebase(
                                        productId: productId,
                                        qty: 1,
                                        context: context,
                                      );
                                    }
                                  },
                                  icon: Icon(
                                    cartProvider.isProductInCart(
                                            productId: productId)
                                        ? Icons.check
                                        : Icons.add_shopping_cart_outlined,
                                    size: 24,
                                    color: cartProvider.isProductInCart(
                                            productId: productId)
                                        ? Colors.green
                                        : Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
