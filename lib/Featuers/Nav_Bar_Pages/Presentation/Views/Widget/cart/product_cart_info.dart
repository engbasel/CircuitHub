import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:store/Core/Utils/app_styles.dart';
import 'package:store/Core/Widget/heart_botton.dart';
import 'package:store/Featuers/Nav_Bar_Pages/Models/cart_model.dart';
import 'package:store/Featuers/Nav_Bar_Pages/Presentation/Views/Widget/cart/quantity_bottom_sheet.dart';

import 'package:store/providers/cart_provider.dart';
import 'package:store/providers/product_provider.dart';

class ProductCartInfo extends StatelessWidget {
  const ProductCartInfo({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    final cartModelProvider = Provider.of<CartModel>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);

    final getCurrProduct =
        productProvider.findByProdId(cartModelProvider.productId);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox(
              width: size.width * 0.6,
              child: Text(
                getCurrProduct!.productTitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppStyles.styleMedium20,
              ),
            ),
            Column(
              children: [
                IconButton(
                  onPressed: () async {
                    // cartProvider.removeOneItem(
                    //     productId: cartModelProvider.productId);
                    await cartProvider.removeCartItemFromFirebase(
                      cartId: cartModelProvider.cartId,
                      productId: cartModelProvider.productId,
                      qty: cartModelProvider.quantity,
                    );
                  },
                  icon: const Icon(
                    Icons.clear,
                    color: Colors.red,
                  ),
                ),
                HeartBottom(
                  productId: getCurrProduct.productId,
                ),
              ],
            ),
          ],
        ),
        Row(
          children: [
            Text(
              '${getCurrProduct.productPrice} \$',
              style: AppStyles.styleMedium20,
            ),
            const Spacer(),
            OutlinedButton.icon(
              onPressed: () async {
                await showModalBottomSheet(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  context: context,
                  builder: (context) {
                    return QuantityBottomSheet(
                      cartModel: cartModelProvider,
                    );
                  },
                );
              },
              icon: const Icon(
                IconlyLight.arrowDown2,
              ),
              label: Text(
                'Qty: ${cartModelProvider.quantity}',
                style: AppStyles.styleMedium16,
              ),
            ),
          ],
        )
      ],
    );
  }
}
