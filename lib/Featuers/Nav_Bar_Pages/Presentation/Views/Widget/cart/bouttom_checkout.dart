import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/Core/Utils/app_styles.dart';
import 'package:store/Core/Widget/custom_botton.dart';
import 'package:store/Featuers/Checkout/CheckoutScreen.dart';
// import 'package:store/Core/Utils/app_styles.dart';
import 'package:store/providers/cart_provider.dart';
import 'package:store/providers/product_provider.dart';

class BouttomCheckout extends StatelessWidget {
  const BouttomCheckout({super.key, required this.function});
  final Function function;

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Total (${cartProvider.getCartItems.length} product /${cartProvider.getQty()} items) ',
                style: AppStyles.styleMedium16,
              ),
              Text(
                '${cartProvider.totalAmount(productProvider: productProvider)}\$',
                style: AppStyles.styleMedium16,
              ),
            ],
          ),
          CustomBotton(
              width: 120,
              onPressed: () async {
                Navigator.popAndPushNamed(context, CheckoutScreen.routeName);
              },
              text: 'Checkout')
        ],
      ),
    );
  }
}
