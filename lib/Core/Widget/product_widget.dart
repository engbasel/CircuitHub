import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/Core/Utils/my_app_method.dart';
import 'package:store/providers/viewed_prod_provider.dart';
import '../../providers/cart_provider.dart';
import '../../providers/product_provider.dart';
import '../../Featuers/Nav_Bar_Pages/Presentation/Views/Widget/inner_widget/product_details.dart';
import '../Utils/app_styles.dart';
import 'heart_botton.dart';

class ProductWidget extends StatefulWidget {
  const ProductWidget({
    super.key,
    required this.productId,
  });
  final String productId;

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  @override
  Widget build(BuildContext context) {
    // final producModeltProvider = Provider.of<ProductModel>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    final viewedRecently = Provider.of<ViewedProdProvider>(context);

    final getCurrProduct = productProvider.findByProdId(widget.productId);
    final cartProvider = Provider.of<CartProvider>(context);

    Size size = MediaQuery.of(context).size;

    return getCurrProduct == null
        ? const SizedBox.shrink()
        : InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () async {
              viewedRecently.addProductToHistory(
                productId: getCurrProduct.productId,
              );
              await Navigator.pushNamed(
                context,
                ProductDetails.routeName,
                arguments: getCurrProduct.productId,
              );
            },
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: FancyShimmerImage(
                    height: size.height * 0.22,
                    width: double.infinity,
                    imageUrl: getCurrProduct.productImage,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        getCurrProduct.productTitle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppStyles.styleMedium20,
                      ),
                    ),
                    Flexible(
                      child: HeartBottom(
                        productId: getCurrProduct.productId,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          '${getCurrProduct.productPrice} \$',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: AppStyles.styleMedium18,
                        ),
                      ),
                      Flexible(
                        child: Material(
                          borderRadius: BorderRadius.circular(14),
                          color: const Color.fromARGB(255, 210, 231, 244),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(14),
                            onTap: () {
                              if (cartProvider.isProductInCart(
                                  productId: getCurrProduct.productId)) {
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
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                  cartProvider.isProductInCart(
                                          productId: getCurrProduct.productId)
                                      ? Icons.check
                                      : Icons.add_shopping_cart_outlined,
                                  size: 20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
          );
  }
}
